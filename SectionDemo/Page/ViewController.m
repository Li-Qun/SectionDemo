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
#import "CustomRefreshViewController.h"
#import "MethodDetailViewController.h"
#import "BrowserViewController.h"
#import "HFWindowViewController.h"
#import "UIAlertView+HFBlock.h"

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
    return 10;
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
    if (row == 3) {
        cell.textLabel.text = @"VC 刷新&&...继续阅读";
    }
    if (row == 4) {
        cell.textLabel.text = @"VC 视频播放和全屏";
    }
    if (row == 5) {
        cell.textLabel.text = @"UIAlertView Block";
    }
    if (row == 6) {
        cell.textLabel.text = @"CustomUrlProtocol";
    }
    if (row == 7) {
        cell.textLabel.text = @"UIWindow 的 windowLevel";
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
    if (row == 3) {
        CustomRefreshViewController *vc = [[CustomRefreshViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 4) {
        MethodDetailViewController *vc = [[MethodDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 5) {
        // Display an alert view with a title and content.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"block alert title" message: @"我是详情" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:@"XXX", nil];
        //__weak typeof(self) weakSelf = self;
        // Add a completion block (using our category to UIAlertView).
        [alertView setCompletionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSLog(@"cancel");
            }
            // If user pressed 'Add'...
            if (buttonIndex == 1) {
                
                NSLog(@"XXXX");
            }
        }];
        
        [alertView show];
    }
    if (row == 6) {
        BrowserViewController *vc = [[BrowserViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (row == 7) {
        HFWindowViewController *vc = [[HFWindowViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
