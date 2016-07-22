//
//  Scanner.h
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#ifndef Scanner_h
#define Scanner_h
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScannerType) {
    ScannerTypeQR = 1,        // 扫一扫 - 二维码
    ScannerTypeCover,         // 扫一扫 - 封面
    ScannerTypeStreet,        // 扫一扫 - 街景
    ScannerTypeTranslate,     // 扫一扫 - 翻译
};


#endif /* Scanner_h */
