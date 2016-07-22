//
//  ScannerButton.m
//  SmallWeChat
//
//  Created by xiaohaiping on 16/7/14.
//  Copyright © 2016年 HaoHe. All rights reserved.
//

#import "ScannerButton.h"
#import <View+MASAdditions.h>
#import "UIColor+Chat.h"

@interface ScannerButton()

@property (strong,nonatomic) UIImageView *iconImageView;
@property (strong,nonatomic) UILabel *textLabel;


@end

@implementation ScannerButton


-(id)initWithType:(ScannerType)type title:(NSString *)title iconPath:(NSString *)iconPath iconHLPath:(NSString *)iconHLPath
{

    if (self = [super init]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.textLabel];
        [self p_addMasonry];
        self.type = type;
        self.title = title;
        self.iconPath = iconPath;
        self.iconHLPath = iconHLPath;
    }
    return self;
}

/**
 *  AutoLayout 布局
 */
-(void)p_addMasonry
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(self.iconImageView.mas_width);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

/**
 *  Getter and Setter
 *
 */
-(UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

-(UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [_textLabel setTextColor:[UIColor whiteColor]];
        [_textLabel setHighlightedTextColor:[UIColor colorGreenDefault]];
    }
    return _textLabel;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    [self.textLabel setText:title];
}

-(void)setIconPath:(NSString *)iconPath
{
    _iconPath = iconPath;
    [self.iconImageView setImage:[UIImage imageNamed:iconPath]];
}

-(void)setIconHLPath:(NSString *)iconHLPath
{
    _iconHLPath = iconHLPath;
    [self.iconImageView setHighlightedImage:[UIImage imageNamed:iconHLPath]];
    
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self.iconImageView setHighlighted:selected];
    [self.textLabel setHighlighted:selected];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
