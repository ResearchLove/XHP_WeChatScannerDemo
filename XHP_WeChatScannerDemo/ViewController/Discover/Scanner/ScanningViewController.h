//
//  ScanningViewController.h
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/19.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "CommonViewController.h"

@interface ScanningViewController : CommonViewController

/**
 *  禁用底部工具栏（默认NO，若开启，将只支持扫码）
 */
@property (nonatomic, assign) BOOL disableFunctionBar;

@end
