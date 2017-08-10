//
//  ViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/9.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
    }
    
    self.title = @"list";
    
    tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

#pragma mark - tableView delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger row =  indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    if (row == 0) {
        cell.textLabel.text = @"VC 1";
    }
    if (row == 1) {
        cell.textLabel.text = @"VC 2";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =  indexPath.row;
    if (row == 0) {
        FirstViewController *vc = [[FirstViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
        SecondViewController *vc = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
