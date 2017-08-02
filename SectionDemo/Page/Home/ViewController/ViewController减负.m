//
//  ViewController减负.m
//  链式DSL学习
//
//  Created by HF on 17/3/8.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "ViewController减负.h"
#import "HomeBannerCell.h"
#import "HomeTableViewDataSource.h"

@interface ViewController__ ()

@property (nonatomic, strong) HomeTableViewDataSource *tabbleViewDataSource;
@end

@implementation ViewController__

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.top.equalTo(self.view);
    }];
    
    //创建实例类tabbleViewDataSource
    //传入数据 这个可以根据实际情况灵活处理
    self.tabbleViewDataSource = [[HomeTableViewDataSource alloc]
                                 initWithItems:@[@"好好",@"学习",@"天天",@"向上"] ];
    
    //设置tableView 两个代理
    self.tableView.dataSource = self.tabbleViewDataSource;
    self.tableView.delegate = self.tabbleViewDataSource;
    
    //每个cell 行 点击触发 response
    TableViewCellBannerAction bannnerAction = ^(id sender) {
        NSLog(@"%@",sender);
    };
    TableViewCellDailyAction dailyAction = ^(id sender) {
        NSLog(@"%@",sender);
    };
    TableViewCellListAction listAction = ^(id sender) {
        NSLog(@"%@",sender);
    };
    self.tabbleViewDataSource.banneryAction = bannnerAction;
    self.tabbleViewDataSource.dailyAction = dailyAction;
    self.tabbleViewDataSource.listAction = listAction;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        //_tableView.dataSource = self;
       // _tableView.delegate = self;
       // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.tableView registerClass:[HomeBannerCell class] forCellReuseIdentifier:kHomeBannerCellID];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewCell"];
       
    }
    return  _tableView;
}


@end
