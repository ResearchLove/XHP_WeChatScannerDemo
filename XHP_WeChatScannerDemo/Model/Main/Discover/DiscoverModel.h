//
//  DiscoverModel.h
//  XHP_WeChatScannerDemo
//
//  Created by xiaohaiping on 16/7/22.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscoverModel : NSObject

@property (copy,nonatomic) NSString *iconPath;
@property (copy,nonatomic) NSString *title;

+(DiscoverModel *)createMenuIconPath:(NSString *)iconPath title:(NSString *)title;

@end
