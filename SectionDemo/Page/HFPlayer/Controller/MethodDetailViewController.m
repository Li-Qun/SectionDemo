//
//  MethodDetailViewController.m
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "MethodDetailViewController.h"
#import "MethodDetailViewController+Video.h"

@interface MethodDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MethodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.tableView.tableHeaderView = self.headView;
    [self createVideoHeaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{   //当前页面消失后继续对视频对象持有的监控释放
    [self cancelVideoObservers];
    NSLog(@"dealloc 释放KVO监督");
}

#pragma mark - 旋转配置

- (BOOL)shouldAutorotate {
    return NO;
}

#pragma mark - setter/getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return  _tableView;
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];;
        _headView.backgroundColor = [UIColor lightGrayColor];
    }
    return _headView;
}

- (HFMovieView *)moviewView
{
    if (!_moviewView) {
        _moviewView = [[HFMovieView alloc]initWithFrame:CGRectMake(0, 0,  self.view.frame.size.width, 200)];
        _moviewView.backgroundColor = [UIColor yellowColor];
    }
    return _moviewView;
}


@end
