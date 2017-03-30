//
//  ActionViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/28.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "ActionViewController.h"
#import "ActionDetailViewController.h"
#import "TransitionFromViewController.h"

#import "NavigationPerfomer.h"
#import "PushAnimation.h"
#import "PopAnimation.h"

@interface ActionViewController () <UITableViewDelegate, UITableViewDataSource,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
{
    NavigationPerfomer *navigationPerFomer;
    UITraitCollection *traitCollection;
}

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    navigationPerFomer = [[NavigationPerfomer alloc]initWithNav:self.navigationController];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = nil; //必须这个位置取消代理 不然 其他页面通用跳转会崩溃
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil; //必须这个位置取消代理 不然 其他页面通用跳转会崩溃
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger row =  indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    if (row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"学习过程效果 0%ld",(indexPath.row + 1)];
    }
    if (row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"自定义效果 0%ld",(indexPath.row + 1)];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =  indexPath.row;
    if (row == 0) {
        self.navigationController.delegate = navigationPerFomer; //需要在这里设置代理
        ActionDetailViewController *vc = [[ActionDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
        self.navigationController.delegate = nil;
        
        TransitionFromViewController *vc = [[TransitionFromViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
