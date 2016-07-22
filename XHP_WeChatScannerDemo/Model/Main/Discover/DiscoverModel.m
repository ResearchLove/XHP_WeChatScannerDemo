//
//  DiscoverModel.m
//  XHP_WeChatScannerDemo
//
//  Created by xiaohaiping on 16/7/22.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "DiscoverModel.h"

@implementation DiscoverModel

+(DiscoverModel *)createMenuIconPath:(NSString *)iconPath title:(NSString *)title
{
    DiscoverModel *discoverModel = [[DiscoverModel alloc]init];
    discoverModel.iconPath = iconPath;
    discoverModel.title = title;
    return discoverModel;
}

@end
