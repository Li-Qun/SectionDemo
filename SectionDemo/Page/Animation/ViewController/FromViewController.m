//
//  FromViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/28.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "FromViewController.h"
#import "ToViewController.h"
#import "HFAnimation.h"

@interface FromViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation FromViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ViewController animation";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    
     cell.textLabel.text = [NSString stringWithFormat:@"VC show %ld fade %ld",(long)indexPath.section,(long)indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ToViewController *vc = [ToViewController new];
    [self.navigationController pushViewController:vc animated:NO];
    
    CATransition *animate =[HFAnimation getShowAnimationIndex:indexPath.section + 1 fadeAnimationIndex:indexPath.row];
    [self.navigationController.view.layer addAnimation:animate forKey:nil];
}


@end
