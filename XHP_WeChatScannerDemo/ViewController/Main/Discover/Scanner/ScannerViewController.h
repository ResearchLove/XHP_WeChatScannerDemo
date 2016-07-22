//
//  ScannerViewController.h
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "CommonViewController.h"
#import "Scanner.h"

@class ScannerViewController;
@protocol ScannerViewControllerDelegate <NSObject>

@optional

-(void)scannerViewControllerInitSuccess: (ScannerViewController *)scannerVC;

-(void)scannerViewController:(ScannerViewController *)scannerVC initFailed:(NSString *)errorString;

-(void)scannerViewController:(ScannerViewController *)scannerVC scanAnswer:(NSString *)ansStr;

@end

@interface ScannerViewController : CommonViewController


@property (nonatomic,assign) ScannerType scannerType;
@property (nonatomic,weak) id <ScannerViewControllerDelegate> delegate;
@property (nonatomic,assign,readonly) BOOL isRunning;
-(void)startCodeReading;
-(void)stopCodeReading;
+ (void)scannerQRCodeFromImage:(UIImage *)image ans:(void (^)(NSString *ansStr))ans;

@end
