//
//  ActionDetailViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/28.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "ActionDetailViewController.h"
#import "NavigationPerfomer.h"

@interface ActionDetailViewController ()
{
    NavigationPerfomer *navigationPerFomer;
}
@end

@implementation ActionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    navigationPerFomer = [[NavigationPerfomer alloc]initWithNav:self.navigationController];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = navigationPerFomer; //需要在这里设置代理
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

- (void)backAction
{
    //[self.navigationController popViewControllerAnimated:YES];
}

@end
