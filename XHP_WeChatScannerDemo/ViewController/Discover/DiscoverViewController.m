//
//  DiscoverViewController.m
//  SmallWeChat
//
//  Created by apple on 15/12/6.
//  Copyright © 2015年 HaoHe. All rights reserved.
//

#import "DiscoverViewController.h"
#import "UIHelper.h"
#import "ShakeViewController.h"
#import "BottleViewController.h"
#import "ShoppingViewController.h"
#import "FriendsCircleVC.h"
#import "ScanningViewController.h"

@interface DiscoverViewController ()

@property (nonatomic,strong) FriendsCircleVC *friCirVC;
@property (nonatomic,strong) ScanningViewController *scanningVC;
@property (nonatomic,strong) ShakeViewController *shakeVC;
@property (nonatomic,strong) BottleViewController *bottleVC;
@property (nonatomic,strong) ShoppingViewController *shoppingVC;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationItem setTitle:@"发现"];
    self.dataSourcesAry = [UIHelper getDiscoverItems];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingGrounp *group = [self.dataSourcesAry objectAtIndex:indexPath.section];
    SettingItem *item = [group itemAtIndex:indexPath.row];
    
    id vc;
    if ([item.title isEqualToString:@"朋友圈"]) {
        vc = self.friCirVC;
    }else if([item.title isEqualToString:@"扫一扫"]){
        vc = [[ScanningViewController alloc]init];
    }else if ([item.title isEqualToString:@"摇一摇"]) {
        vc = self.shakeVC;
    }else if([item.title isEqualToString:@"漂流瓶"]){
        vc = self.bottleVC;
    
    }else if([item.title isEqualToString:@"购物"]){
        vc = self.shoppingVC;
    }
    if (vc != nil) {
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - Getter and Setter
-(FriendsCircleVC *)friCirVC
{
    if (_friCirVC == nil) {
        _friCirVC = [[FriendsCircleVC alloc]init];
    }
    return _friCirVC;
}

-(ShakeViewController *)shakeVC
{
    if (_shakeVC == nil) {
        _shakeVC = [[ShakeViewController alloc]init];
    }
    return _shakeVC;
}

-(ScanningViewController *)scanningVC
{
    if (_scanningVC == nil) {
        _scanningVC = [[ScanningViewController alloc]init];
    }
    return _scanningVC;
}

-(BottleViewController *)bottleVC
{
    if (_bottleVC == nil) {
        _bottleVC = [[BottleViewController alloc]init];
    }
    return _bottleVC;
}

-(ShoppingViewController *)shoppingVC
{
    if (_shakeVC == nil) {
        _shoppingVC = [[ShoppingViewController alloc]init];
    }
    return _shoppingVC;


}


- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setHidesBottomBarWhenPushed:NO];
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
