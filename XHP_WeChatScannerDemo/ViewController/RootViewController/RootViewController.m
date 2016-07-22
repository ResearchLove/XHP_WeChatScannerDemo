//
//  RootViewController.m
//  SmallWeChat
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 HaoHe. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tabBar setBackgroundColor:DEFAULT_SEARCHBAR_COLOR];
    [self.tabBar setTintColor:DEFAULT_GREEN_COLOR];
    
    NavigationViewController *messageNavC = [[NavigationViewController alloc]initWithRootViewController:self.messageListViewController];
    NavigationViewController *adressBookNavC = [[NavigationViewController alloc]initWithRootViewController:self.addressBookViewController];
    NavigationViewController *discoverNavC = [[NavigationViewController alloc]initWithRootViewController:self.discoverViewController];
    NavigationViewController *mineNavC = [[NavigationViewController alloc]initWithRootViewController:self.mineViewController];
    [self setViewControllers:@[messageNavC,adressBookNavC,discoverNavC,mineNavC]];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Getter and Setter


//消息
-(MessageListViewController *)messageListViewController
{

    if (_messageListViewController == nil) {
        _messageListViewController = [[MessageListViewController alloc]init];
        [_messageListViewController.tabBarItem setTitle:@"消息"];
        [_messageListViewController.tabBarItem setImage:[UIImage imageNamed:@"tabbar_message"]];
        [_messageListViewController.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_messageSE"]];
    }
    return _messageListViewController;

}


//通讯录
-(AddressBookViewController *)addressBookViewController
{
    
    if (_addressBookViewController == nil) {
        _addressBookViewController = [[AddressBookViewController alloc]init];
        [_addressBookViewController.tabBarItem setTitle:@"通讯录"];
        [_addressBookViewController.tabBarItem setImage:[UIImage imageNamed:@"tabbar_addressBooks"]];
        [_addressBookViewController.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_addressBooksSE"]];
    }
    return _addressBookViewController;
    
}

//发现
-(DiscoverViewController *)discoverViewController
{
    
    if (_discoverViewController == nil) {
        _discoverViewController = [[DiscoverViewController alloc]init];
        [_discoverViewController.tabBarItem setTitle:@"发现"];
        [_discoverViewController.tabBarItem setImage:[UIImage imageNamed:@"tabbar_discover"]];
        [_discoverViewController.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    }
    return _discoverViewController;
    
}

//我
-(MineViewController *)mineViewController
{
    
    if (_mineViewController == nil) {
        _mineViewController = [[MineViewController alloc]init];
        [_mineViewController.tabBarItem setTitle:@"我"];
        [_mineViewController.tabBarItem setImage:[UIImage imageNamed:@"tabbar_mine"]];
        [_mineViewController.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabbar_mineSE"]];
    }
    return _mineViewController;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
