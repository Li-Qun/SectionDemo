//
//  ViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/9.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "ViewController.h"
#import "ViewController减负.h"
#import "ActionViewController.h"
#import "FromViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ViewController 减负";
    
     tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:tableView];
}

#pragma mark - tableView delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSInteger row =  indexPath.row;
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    if (row == 0) {
        cell.textLabel.text = @"VC 减负";
    }
    if (row == 1) {
        cell.textLabel.text = @"VC 转场";
    }
    if (row == 2) {
        cell.textLabel.text = @"VC animation";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =  indexPath.row;
    if (row == 0) {
        ViewController__ *vc = [[ViewController__ alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
        ActionViewController *vc = [[ActionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 2) {
        FromViewController *vc = [[FromViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
