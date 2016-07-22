//
//  ScanningViewController.m
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/19.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "ScanningViewController.h"
#import "ScannerViewController.h"
#import "CommonWebViewController.h"
#import "ScannerButton.h"
#import <View+MASAdditions.h>
#import "UIColor+Chat.h"
#import <UIAlertView+BlocksKit.h>
#import "CommonWebViewController.h"
#import "UINavigationController+StackManager.h"
#import "UINavigationController+JZExtension.h"
#import "UIImagePickerController+RACSignalSupport.h"
#import "RACDelegateProxy.h"
#import "RACSignal+Operations.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import <objc/runtime.h>
#import "SVProgressHUD.h"

#define     HEIGHT_BOTTOM_VIEW      82

@interface ScanningViewController () <ScannerViewControllerDelegate>

@property (assign,nonatomic) ScannerType curType;
@property (strong,nonatomic) ScannerViewController *scannerVC;
@property (strong,nonatomic) UIBarButtonItem *albumBarButton;
@property (strong,nonatomic) UIButton *myQRButton;

@property (strong,nonatomic) UIView *bottomView;
@property (strong,nonatomic) ScannerButton *qrButton;
@property (strong,nonatomic) ScannerButton *coverButton;
@property (strong,nonatomic) ScannerButton *streeButton;
@property (strong,nonatomic) ScannerButton *translateButton;

@end

@implementation ScanningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.scannerVC.view];
    [self addChildViewController:self.scannerVC];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.myQRButton];
    
    [self.bottomView addSubview:self.qrButton];
    [self.bottomView addSubview:self.coverButton];
    [self.bottomView addSubview:self.streeButton];
    [self.bottomView addSubview:self.translateButton];

    [self p_addMasonry];
    // Do any additional setup after loading the view.
}

/**
 *  AutoLayout 布局
 */
-(void)p_addMasonry
{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_BOTTOM_VIEW);
    }];

    CGFloat widthButton = 35;
    CGFloat heightButton = 55;
    CGFloat space = (WIDTH_SCREEN - widthButton * 4) / 5;
    [self.qrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(self.bottomView).mas_offset(space);
        make.width.mas_equalTo(widthButton);
        make.height.mas_equalTo(heightButton);
    }];
    
    [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.mas_equalTo(self.qrButton);
        make.left.mas_equalTo(self.qrButton.mas_right).mas_offset(space);
    }];
    
    [self.streeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.mas_equalTo(self.qrButton);
        make.left.mas_equalTo(self.coverButton.mas_right).mas_offset(space);
    }];
    
    [self.translateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.mas_equalTo(self.qrButton);
        make.left.mas_equalTo(self.streeButton.mas_right).mas_offset(space);
    }];
    
    [self.myQRButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(-40);
    }];
}

/**
 *  Getter and Setter
 */
-(ScannerViewController *)scannerVC
{
    if (_scannerVC == nil) {
        _scannerVC = [[ScannerViewController alloc]init];
        [_scannerVC setDelegate:self];
    }
    return _scannerVC;
}

-(UIView *)bottomView
{

    if (_bottomView == nil) {
        UIView *blackView = [[UIView alloc]init];
        [blackView setBackgroundColor:[UIColor blackColor]];
        [blackView setAlpha:0.5f];
        _bottomView = [[UIView alloc]init];
        [_bottomView addSubview:blackView];
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bottomView);
        }];
    }
    return _bottomView;
}

-(ScannerButton *)qrButton
{
    if (_qrButton == nil) {
        _qrButton = [[ScannerButton alloc]initWithType:ScannerTypeQR title:@"扫码" iconPath:@"scan_QR" iconHLPath:@"scan_QR_HL"];
        [_qrButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qrButton;
}

-(ScannerButton *)coverButton
{
    if (_coverButton == nil) {
        _coverButton = [[ScannerButton alloc]initWithType:ScannerTypeCover title:@"封面" iconPath:@"scan_book" iconHLPath:@"scan_book_HL"];
        [_coverButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverButton;
}

-(ScannerButton *)streeButton
{

    if (_streeButton == nil) {
        _streeButton = [[ScannerButton alloc]initWithType:ScannerTypeStreet title:@"街景" iconPath:@"scan_street" iconHLPath:@"scan_street_HL"];
        [_streeButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _streeButton;
}

-(ScannerButton *)translateButton
{
    if (_translateButton == nil) {
        _translateButton = [[ScannerButton alloc]initWithType:ScannerTypeTranslate title:@"翻译" iconPath:@"scan_word" iconHLPath:@"scan_word_HL"];
        [_translateButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _translateButton;
}

- (UIBarButtonItem *)albumBarButton
{
    if (_albumBarButton == nil) {
        _albumBarButton = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(albumBarButtonDown:)];
    }
    return _albumBarButton;
}

-(UIButton *)myQRButton
{
    if (_myQRButton == nil) {
        _myQRButton = [[UIButton alloc]init];
        [_myQRButton setTitle:@"我的二维码" forState:UIControlStateNormal];
        [_myQRButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_myQRButton setTitleColor:[UIColor colorGreenDefault] forState:UIControlStateNormal];
        [_myQRButton addTarget:self action:@selector(myQRButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        [_myQRButton setHidden:YES];
    }
    return _myQRButton;
}

/**
 *  不同类型的扫描事件
 *
 */
-(void)scannerButtonDown:(ScannerButton *)sender
{
    if (sender.isSelected) {
        if (![self.scannerVC isRunning]) {
            [self.scannerVC startCodeReading];
        }
        return;
    }
    
    self.curType = sender.type;
    [self.qrButton setSelected:self.qrButton.type == sender.type];
    [self.coverButton setSelected:self.coverButton.type == sender.type];
    [self.streeButton setSelected:self.streeButton.type == sender.type];
    [self.translateButton setSelected:self.translateButton.type == sender.type];
    
    if (sender.type == ScannerTypeQR) {
        [self.navigationItem setRightBarButtonItem:self.albumBarButton];
        [self.myQRButton setHidden:NO];
        [self.navigationItem setTitle:@"二维码/条码"];
    }else{
        [self.navigationItem setRightBarButtonItem:nil];
        [self.myQRButton setHidden:YES];
        if (sender.type == ScannerTypeCover) {
            [self.navigationItem setTitle:@"封面"];
        }else if(sender.type == ScannerTypeStreet){
            [self.navigationItem setTitle:@"街景"];
        }else if(sender.type == ScannerTypeTranslate){
            [self.navigationItem setTitle:@"翻译"];
        }
    }
    [self.scannerVC setScannerType:sender.type];
}

/**
 *  相册选择事件
 *
 *  @param sender
 */
-(void)albumBarButtonDown:(UIBarButtonItem *)sender
{
    [self.scannerVC stopCodeReading];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imagePickerController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    [self presentViewController:imagePickerController animated:YES completion:nil];
    [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
        [imagePickerController dismissViewControllerAnimated:YES completion:^{
            UIImage *image = [x objectForKey:UIImagePickerControllerOriginalImage];
            [SVProgressHUD showWithStatus:@"扫描中，请稍候"];
            [ScannerViewController scannerQRCodeFromImage:image ans:^(NSString *ansStr) {
                [SVProgressHUD dismiss];
                if (ansStr == nil) {
                    [UIAlertView bk_showAlertViewWithTitle:@"扫描失败" message:@"请换张图片，或换个设备重试~" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                        [self.scannerVC startCodeReading];
                    }];
                }else{
                    [self p_analysisQRAnswer:ansStr];
                }
            }];
        }];
    } completed:^{
        [imagePickerController dismissViewControllerAnimated:YES completion:nil];
    }];

}
/**
 *  我的二维码事件
 *
 *  @param sender
 */
-(void)myQRButtonDown:(UIButton *)sender
{

    NSLog(@"click my QRCode... ");

}

/**
 *  ScannerViewControllerDelegate
 *
 *  @param scannerVC
 */
-(void)scannerViewControllerInitSuccess:(ScannerViewController *)scannerVC
{
    [self scannerButtonDown:self.qrButton];
}

-(void)scannerViewController:(ScannerViewController *)scannerVC initFailed:(NSString *)errorString
{
    [UIAlertView bk_showAlertViewWithTitle:@"错误" message:errorString cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)scannerViewController:(ScannerViewController *)scannerVC scanAnswer:(NSString *)ansStr
{
    [self p_analysisQRAnswer:ansStr];
}

/**
 *  扫描后处理事件
 *
 */
-(void)p_analysisQRAnswer:(NSString *)ansStr
{
    if ([ansStr hasPrefix:@"http"]) {
        CommonWebViewController *webVC = [[CommonWebViewController alloc]init];
        [webVC setUrl:ansStr];
        __block id vc = self.navigationController.rootViewController;
        [self.navigationController popViewControllerAnimated:NO completion:^(BOOL finished) {
            if (finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [vc setHidesBottomBarWhenPushed:YES];
                    [[vc navigationController] pushViewController:webVC animated:YES];
                    [vc setHidesBottomBarWhenPushed:NO];
                });
            }
        }];
    }else{
        [UIAlertView bk_showAlertViewWithTitle:@"扫描结果" message:ansStr cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            [self.scannerVC startCodeReading];
        }];
    }
}


-(void)setDisableFunctionBar:(BOOL)disableFunctionBar
{
    _disableFunctionBar = disableFunctionBar;
    [self.bottomView setHidden:disableFunctionBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
