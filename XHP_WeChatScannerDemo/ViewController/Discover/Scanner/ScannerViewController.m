//
//  ScannerViewController.m
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "ScannerViewController.h"
#import "ScannerView.h"
#import "ScannerBackgroundView.h"
#import "UIView+Frame.h"
#import <AVFoundation/AVFoundation.h>
#import <View+MASAdditions.h>

@interface ScannerViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (strong,nonatomic) UILabel *introudctionLabel;
@property (strong,nonatomic) ScannerView *scannerView;
@property (strong,nonatomic) ScannerBackgroundView *scannerBackgroundView;

@property (strong,nonatomic) AVCaptureSession *scannerSession;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation ScannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.introudctionLabel];
    [self.view addSubview:self.scannerView];
    [self.view addSubview:self.scannerBackgroundView];
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
    
    [self p_addMasonry];
    // Do any additional setup after loading the view.
}

/**
 *  AutoLayout 布局
 */
-(void)p_addMasonry
{

    [self.scannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(-55);
        make.width.and.height.mas_equalTo(0);
    }];
    
    [self.scannerBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [_scannerBackgroundView addMasonryWithContainView:self.scannerView];
    
    [self.introudctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scannerView.mas_bottom).mas_offset(30);
    }];
}


/**
 *  Getter and Setter
 *
 */
-(AVCaptureSession *)scannerSession
{

    if (_scannerSession == nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {//没有摄像头
            return nil;
        }
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        AVCaptureSession *session = [[AVCaptureSession alloc]init];
        if ([session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
            [session setSessionPreset:AVCaptureSessionPreset1920x1080];
        }else if([session canSetSessionPreset:AVCaptureSessionPreset1280x720]){
            [session setSessionPreset:AVCaptureSessionPreset1280x720];
        }else{
            [session setSessionPreset:AVCaptureSessionPresetPhoto];
        }
        
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode]];
        _scannerSession = session;
    }
    return _scannerSession;
}

-(AVCaptureVideoPreviewLayer *)videoPreviewLayer
{
    if (_videoPreviewLayer == nil) {
        _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.scannerSession];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [_videoPreviewLayer setFrame:self.view.layer.bounds];
    }
    return _videoPreviewLayer;
}

-(UILabel *)introudctionLabel
{
    if (_introudctionLabel == nil) {
        _introudctionLabel = [[UILabel alloc]init];
        [_introudctionLabel setBackgroundColor:[UIColor clearColor]];
        [_introudctionLabel setTextAlignment:NSTextAlignmentCenter];
        [_introudctionLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_introudctionLabel setTextColor:[UIColor whiteColor]];
    }
    return _introudctionLabel;
}

-(ScannerView *)scannerView
{
    if (_scannerView == nil) {
        _scannerView = [[ScannerView alloc]init];
    }
    return _scannerView;
}

-(ScannerBackgroundView *)scannerBackgroundView
{
    if (_scannerBackgroundView == nil) {
        _scannerBackgroundView = [[ScannerBackgroundView alloc]init];
    }
    return _scannerBackgroundView;
}

+(void)scannerQRCodeFromImage:(UIImage *)image ans:(void (^)(NSString *))ans
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 1));
        CIImage *ciImage = [CIImage imageWithData:imageData];
        NSString  *ansStr = nil;
        if (ciImage) {
            CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:[CIContext contextWithOptions:nil] options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
            NSArray *features = [detector featuresInImage:ciImage];
            if (features.count) {
                for (CIFeature *feature in features) {
                    if ([feature isKindOfClass:[CIQRCodeFeature class]]) {
                        ansStr = ((CIQRCodeFeature *)feature).messageString;
                        break;
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ans(ansStr);
        });
    });
}

-(void)setScannerType:(ScannerType)scannerType
{
    if (_scannerType == scannerType) {
        return;
    }
    _scannerType = scannerType;
    CGFloat width = 0;
    CGFloat height = 0;
    if (scannerType == ScannerTypeQR) {
        [self.introudctionLabel setText:@"将二维码/条码放入框内，即可自动扫描"];
        width = height = WIDTH_SCREEN * 0.7;
    }else if(scannerType == ScannerTypeCover){
        [self.introudctionLabel setText:@"将书、CD、电影海报放入框内，即可自动扫描"];
        width = height = WIDTH_SCREEN * 0.85;
    }else if(scannerType == ScannerTypeStreet){
        [self.introudctionLabel setText:@"扫一下周围环境，寻找附近街景"];
        width = height = WIDTH_SCREEN * 0.85;
    }else if(scannerType == ScannerTypeTranslate){
        width = WIDTH_SCREEN * 0.7;
        height = 55;
        [self.introudctionLabel setText:@"将英文单词放入框内"];
    }
    
    [self.scannerView setHiddenScannerIndicator:scannerType == ScannerTypeTranslate];
    [UIView animateWithDuration:0.3 animations:^{
        [self.scannerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        [self.view layoutIfNeeded];
    }];
    
    //rect值范围0-1，基准点在右上角
    CGRect rect = CGRectMake(self.scannerView.y / HEIGHT_SCREEN,self.scannerView.x / WIDTH_SCREEN, self.scannerView.frameHeight / HEIGHT_SCREEN, self.scannerView.frameWidth / WIDTH_SCREEN);
    [self.scannerSession.outputs[0] setRectOfInterest:rect];
    if (!self.isRunning) {
        [self startCodeReading];
    }
}

/**
 *  开始扫描
 */
-(void)startCodeReading
{
    [self.scannerView startScanner];
    [self.scannerSession startRunning];

}

/**
 * 停止扫描
 *
 */
-(void)stopCodeReading
{
    [self.scannerView stopScanner];
    [self.scannerSession stopRunning];
}

-(BOOL)isRunning
{
    return [self.scannerSession isRunning];
}

/**
 *  AVCaptureMetadataOutputObjectsDelegate
 *
 */
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [self stopCodeReading];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewController:scanAnswer:)]) {
            [_delegate scannerViewController:self scanAnswer:obj.stringValue];
        }
    }
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.scannerSession) {
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewControllerInitSuccess:)]) {
            [_delegate scannerViewControllerInitSuccess:self];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewController:initFailed:)]) {
            [_delegate scannerViewController:self initFailed:@"相机初始化失败"];
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.scannerSession isRunning]) {
        [self stopCodeReading];
    }
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
