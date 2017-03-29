//
//  TransitionFromViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TransitionFromViewController.h"
#import "TransitionToViewController.h"
#import "TransitionCell.h"

@interface TransitionFromViewController () <UITableViewDelegate, UITableViewDataSource,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation TransitionFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[TransitionCell class] forCellReuseIdentifier:@"TransitionCell"];

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
    NSInteger row =  indexPath.row;
    if (row == 0) {
        return 100;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger row =  indexPath.row;
    
    if (row == 0) {
        TransitionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransitionCell" forIndexPath:indexPath];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =  indexPath.row;
    if (row == 0) {
        TransitionToViewController *vc = [[TransitionToViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
