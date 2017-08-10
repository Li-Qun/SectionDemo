//
//  HFSettingViewController.m
//  SectionDemo
//
//  Created by HF on 2017/7/19.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFSettingViewController.h"
#import "TestViewController.h"
#import "HFSettingCell.h"
//model
#import "HFSettingGroup.h"
#import "HFSettingItem.h"

@interface HFSettingViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableView;
}

@property (nonatomic, strong) NSMutableArray *groupArrays;

@end

@implementation HFSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[HFSettingCell class] forCellReuseIdentifier:kHFSettingCellId];
    [self.view addSubview:tableView];
    
    [self buildTableDataThen:^{
        [tableView reloadData];
    }];
}

#pragma mark 添加第0组的模型数据

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupArrays.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    HFSettingGroup *group = self.groupArrays[ section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HFSettingCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    HFSettingGroup *group = self.groupArrays[indexPath.section];
    HFSettingItem *item = group.items[indexPath.row];
    HFSettingCell *cell = [tableView1 dequeueReusableCellWithIdentifier:kHFSettingCellId];
    [cell setCellTitle:item.title content:item.content];
    return cell;
    return  [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HFSettingGroup *group = self.groupArrays[indexPath.section];
    HFSettingItem *item = group.items[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (item.operation) {
        item.operation();
    }
}

#pragma mark -- 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    HFSettingGroup *group = self.groupArrays[section];
    return group.header;
}
#pragma mark -- 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    HFSettingGroup *group;
    
    return group.footer;
}

#pragma mark - private

- (void)buildTableDataThen:(void (^)(void))then
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //data from  array
        [self addSectionItems];
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

#pragma mark -- 添加第0组的模型数据
- (void)addSectionItems
{
    self.groupArrays = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    // 1.1.月经测试
    HFSettingItem *test = [HFSettingItem itemWithIcon:nil title:@"月经测试" content:@"未测试"];
    //cell点击事件
    test.operation = ^{
        //TODO: test
        NSLog(@"test");
    };
    // 1.2测试结果
    HFSettingItem *result = [HFSettingItem itemWithIcon:nil title:@"测试结果" content:@"平和质"];
    result.operation = ^{
        //TODO: test
        NSLog(@"result");
        TestViewController *vc = [TestViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    HFSettingGroup *group = [[HFSettingGroup alloc] init];
    group.header = @"第一组";
    group.items = @[test,result];
    [self.groupArrays addObject:group];
    
    // 2.1意见反馈
    HFSettingItem *suggest = [HFSettingItem itemWithIcon:nil title:@"意见反馈" content:nil];
    suggest.operation = ^{
        NSLog(@"suggest");
        TestViewController *vc = [TestViewController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    HFSettingGroup *group1 = [[HFSettingGroup alloc] init];
    group1.items = @[suggest];
    group1.header = @"第二组";
    [self.groupArrays addObject:group1];
}


@end
