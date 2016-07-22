//
//  DiscoverCell.h
//  XHP_WeChatScannerDemo
//
//  Created by xiaohaiping on 16/7/22.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "DiscoverModel.h"

@interface DiscoverCell : CommonTableViewCell

@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *titleLabel;

@property (strong,nonatomic) DiscoverModel *discoverModel;

@end
