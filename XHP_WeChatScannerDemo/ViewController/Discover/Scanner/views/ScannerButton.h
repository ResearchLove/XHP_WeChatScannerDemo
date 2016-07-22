//
//  ScannerButton.h
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Scanner.h"

@interface ScannerButton : UIButton

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *iconPath;
@property (strong,nonatomic) NSString *iconHLPath;
@property (assign,nonatomic) ScannerType type;
@property (assign,nonatomic) NSUInteger msgNumber;

- (id) initWithType:(ScannerType)type title:(NSString *)title iconPath:(NSString *)iconPath iconHLPath:(NSString *)iconHLPath;

@end
