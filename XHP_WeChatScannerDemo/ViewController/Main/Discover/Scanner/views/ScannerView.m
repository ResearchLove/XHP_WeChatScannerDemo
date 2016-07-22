//
//  ScannerView.m
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "ScannerView.h"
#import "UIView+Frame.h"
#import <View+MASAdditions.h>
#import <BlocksKit.h>

@interface ScannerView()
{
    NSTimer *timer;
}

@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) UIImageView *topLeftView;
@property (strong,nonatomic) UIImageView *topRightView;
@property (strong,nonatomic) UIImageView *btmLeftView;
@property (strong,nonatomic) UIImageView *btmRightView;
@property (strong,nonatomic) UIImageView *scannerLine;

@end


@implementation ScannerView

-(id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self setClipsToBounds:YES];
        [self addSubview:self.bgView];
        [self addSubview:self.topLeftView];
        [self addSubview:self.topRightView];
        [self addSubview:self.btmLeftView];
        [self addSubview:self.btmRightView];
        [self addSubview:self.scannerLine];
        [self p_addMasonary];
    }
    return self;

}

/**
 *  AutoLayout 布局
 */
-(void)p_addMasonary
{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [_topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self);
        make.width.and.height.mas_lessThanOrEqualTo(self);
    }];
    
    [_topRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.mas_equalTo(self);
        make.width.and.height.mas_lessThanOrEqualTo(self);
    }];
    
    [_btmLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.mas_equalTo(self);
        make.width.and.height.mas_lessThanOrEqualTo(self);
    }];
    
    [_btmRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.mas_equalTo(self);
        make.width.and.height.mas_lessThanOrEqualTo(self);
    }];
    
}

/**
 * Getter and Setter
 *
 */
-(UIView *)bgView
{
    if (_bgView == nil) {
        _bgView = [[UIView alloc]init];
        [_bgView setBackgroundColor:[UIColor clearColor]];
        [_bgView.layer setMasksToBounds:YES];
        [_bgView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_bgView.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    return _bgView;
}

-(UIImageView *)topLeftView
{
    if (_topLeftView == nil) {
        _topLeftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanner_top_left"]];
    }
    return _topLeftView;
}

-(UIImageView *)topRightView
{
    if (_topRightView == nil) {
        _topRightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanner_top_right"]];
    }
    return _topRightView;
}

-(UIImageView *)btmLeftView
{
    if (_btmLeftView == nil) {
        _btmLeftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanner_bottom_left"]];
    }
    return _btmLeftView;

}

-(UIImageView *)btmRightView
{
    if (_btmRightView == nil) {
        _btmRightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanner_bottom_right"]];
    }
    return _btmRightView;
}

-(UIImageView *)scannerLine
{
    if (_scannerLine == nil) {
        _scannerLine = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scanner_line"]];
        [_scannerLine setFrame:CGRectZero];
    }
    return _scannerLine;
}

-(void)setHiddenScannerIndicator:(BOOL)hiddenScannerIndicator
{
    if (hiddenScannerIndicator == _hiddenScannerIndicator) {
        return;
    }
    
    if (hiddenScannerIndicator) {
        self.scannerLine.y = 0;
        [self.scannerLine setHeight:YES];
        _hiddenScannerIndicator = hiddenScannerIndicator;
    }else{
        _hiddenScannerIndicator = hiddenScannerIndicator;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scannerLine.y = 0;
            [self.scannerLine setHidden:hiddenScannerIndicator];
        });
    }
}

/**
 *  开始扫描
 */
-(void)startScanner
{
    [self stopScanner];
    timer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0/60.0 block:^(NSTimer *timer) {
        if (self.hiddenScannerIndicator) {
            return;
        }
        self.scannerLine.centerX = self.bgView.centerX;
        self.scannerLine.width = self.bgView.width * 1.4;
        self.scannerLine.height = 10.0f;
        if (self.scannerLine.y + self.scannerLine.height >= self.height) {
            self.scannerLine.y = 0;
        }else{
            self.scannerLine.y ++;
        }
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  停止扫描
 */
-(void)stopScanner
{
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
