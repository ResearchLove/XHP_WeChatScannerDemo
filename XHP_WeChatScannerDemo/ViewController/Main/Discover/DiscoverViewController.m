//
//  DiscoverViewController.m
//  XHP_WeChatScannerDemo
//
//  Created by xiaohaiping on 16/7/22.
//  Copyright © 2016年 HaoHeHealth. All rights reserved.
//

#import "DiscoverViewController.h"
#import "UIColor+Chat.h"
#import "DiscoverCell.h"
#import "DiscoverHelper.h"
#import "DiscoverModel.h"
#import "ScanningViewController.h"

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setHidesBottomBarWhenPushed:NO];
     [self.navigationItem setTitle:@"发现"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setBackgroundColor:[UIColor colorGrayBG]];
    [self.tableView setSeparatorColor:[UIColor colorGrayLine]];
    [self.tableView registerClass:[DiscoverCell class] forCellReuseIdentifier:@"DiscoverCell"];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    DiscoverHelper *discoverHelper = [[DiscoverHelper alloc]init];
    self.dataAry = discoverHelper.dataAry;

    // Do any additional setup after loading the view.
}


/**
 *  UITableViewDataSource
 *
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataAry.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataAry[section] count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverModel *discoverModel = [self.dataAry[indexPath.section] objectAtIndex:indexPath.row];
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell"];
    [cell setDiscoverModel:discoverModel];
    
    if (indexPath.section == 0 || indexPath.section == 2) {
        [cell setTopLineStyle:CellLineStyleFill];
        [cell setBottonLineStyle:CellLineStyleFill];
    }else{
        indexPath.row == 0 ? [cell setTopLineStyle:CellLineStyleFill] : [cell setTopLineStyle:CellLineStyleNone];
        indexPath.row == [_dataAry[indexPath.section] count] - 1 ? [cell setBottonLineStyle:CellLineStyleFill] : [cell setBottonLineStyle:CellLineStyleDefault];
        
    }
    return cell;
}

/**
 *  UITableViewDelegate
 *
 */
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverModel *discoverModel = [self.dataAry[indexPath.section] objectAtIndex:indexPath.row];
    if ([discoverModel.title isEqualToString:@"扫一扫"]) {
        ScanningViewController *scanningVC = [[ScanningViewController alloc]init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:scanningVC animated:YES];
    }

}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setHidesBottomBarWhenPushed:NO];
}



@end
