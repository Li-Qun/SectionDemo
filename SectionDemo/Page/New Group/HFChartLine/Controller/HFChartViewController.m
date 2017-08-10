//
//  HFChartViewController.m
//  SectionDemo
//
//  Created by HF on 2017/8/2.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFChartViewController.h"
#import "TestViewController.h"
#import "HFChartLineCell.h"

@interface HFChartViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
}
@end

@implementation HFChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[HFChartLineCell class] forCellReuseIdentifier:kHFChartLineCellId];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 45 *3 + 45;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row == 0) {
        HFChartLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kHFChartLineCellId] ;
        [cell configUI:indexPath];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //none
    TestViewController *vc = [TestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
