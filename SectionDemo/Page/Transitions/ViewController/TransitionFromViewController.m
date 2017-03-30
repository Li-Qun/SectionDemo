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

#import "TransitionNavigationPerformer.h"

@interface TransitionFromViewController () <UITableViewDelegate, UITableViewDataSource,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>
{
    TransitionNavigationPerformer *navPerformer;
}
@end

@implementation TransitionFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"列表";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TransitionCell class] forCellReuseIdentifier:@"TransitionCell"];
    
    navPerformer = [[TransitionNavigationPerformer alloc]initWithNav:self.navigationController];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
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
        
        self.navigationController.delegate = navPerformer;
        TransitionToViewController *vc = [[TransitionToViewController alloc]init];
        vc.index = @(indexPath.row);
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - private

- (TransitionCell *)tableViewCellForModel:(id)sender {

    NSInteger index = [sender integerValue];
    if (index == NSNotFound) {
        return nil;
    }
    return (TransitionCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}
@end
