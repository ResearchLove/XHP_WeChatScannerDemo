//
//  RootViewController.h
//  SmallWeChat
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 HaoHe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListViewController.h"
#import "AddressBookViewController.h"
#import "DiscoverViewController.h"
#import "MineViewController.h"

@interface RootViewController : UITabBarController
@property (strong,nonatomic) MessageListViewController *messageListViewController;
@property (strong,nonatomic) AddressBookViewController *addressBookViewController;
@property (strong,nonatomic) DiscoverViewController *discoverViewController;
@property (strong,nonatomic) MineViewController *mineViewController;


@end
