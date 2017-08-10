//
//  SecondViewController.m
//  SectionDemo
//
//  Created by HF on 2017/8/10.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"list2";
    
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
        cell.textLabel.text = @"list2";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =  indexPath.row;
    if (row == 0) {
        
//        ViewController *vc = [[ViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 1) {
      
    }
}

@end
