//
//  ScannerView.h
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScannerView : UIView

/**
 *  隐藏扫描指示器，默认NO
 */
@property (nonatomic, assign) BOOL hiddenScannerIndicator;

- (void)startScanner;

- (void)stopScanner;

@end
