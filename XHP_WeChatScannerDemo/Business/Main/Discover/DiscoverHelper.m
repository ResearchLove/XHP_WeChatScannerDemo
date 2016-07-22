//
//  DiscoverHelper.m
//  XHP_WeChatScannerDemo
//
//  Created by xiaohaiping on 16/7/22.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "DiscoverHelper.h"
#import "DiscoverModel.h"

@implementation DiscoverHelper

-(id)init
{
    if (self = [super init]) {
        self.dataAry = [[NSMutableArray alloc]init];
        [self initTextData];
    }
    return self;
}

-(void)initTextData
{
    DiscoverModel *discoverModelOne = [DiscoverModel createMenuIconPath:@"" title:@""];
    DiscoverModel *discoverModelTwo = [DiscoverModel createMenuIconPath:@"scanner" title:@"扫一扫"];
    DiscoverModel *discoverModelThree = [DiscoverModel createMenuIconPath:@"" title:@""];
    DiscoverModel *discoverModelFour = [DiscoverModel createMenuIconPath:@"" title:@""];
    DiscoverModel *discoverModelFive = [DiscoverModel createMenuIconPath:@"" title:@""];
    DiscoverModel *discoverModelSix = [DiscoverModel createMenuIconPath:@"" title:@""];
    DiscoverModel *discoverModelSeven = [DiscoverModel createMenuIconPath:@"" title:@""];
    
    [_dataAry addObjectsFromArray:@[@[discoverModelOne],@[discoverModelTwo,discoverModelThree],@[discoverModelFour,discoverModelFive],@[discoverModelSix,discoverModelSeven]]];
    
}

@end
