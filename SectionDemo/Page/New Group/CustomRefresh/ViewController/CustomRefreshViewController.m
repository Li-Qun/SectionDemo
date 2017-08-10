//
//  CustomRefreshViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/30.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "CustomRefreshViewController.h"
#import "HFRefreshHeader.h"
#import "HFReadMoreCell.h"

@interface CustomRefreshViewController () <UITableViewDelegate,UITableViewDataSource>
{
    BOOL isLoadCard;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *statusArray;
@end

@implementation CustomRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"刷新&&...继续阅读";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    NSLog(@"%@",_tableView);
    
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:@{@"content":@"哈"}];
    [self.dataArray addObject:@{@"content":@"河北新闻网4月6日讯，近日，河北出入境检验检疫局京唐港办事处对一批来自荷兰的集装箱进行查验时，截获了象甲类昆虫，经专家鉴定为野豌豆叶象，为我国口岸首次发现。",@"isExpand": @"1"}];
    [self.dataArray addObject:@{@"content":@"网站4月5日报道，俄罗斯暗示放弃国际空间站，然后与中国共同建设一个基地",@"isExpand": @"1"}];
    [self.dataArray addObject:@{@"content":@"俄罗斯联邦太空局Roscosmos，正在考虑放弃让人类宇航员参与新的空间站，倾向于用机器人。"}];
    [self.dataArray addObject:@{@"content":@"加剧了俄罗斯和西方之间的紧张关系"}];
    
    [self.dataArray addObject:@{@"content":@"伊欧宁说，俄罗斯与中国可以建立这样的空间站，无论在技术上还是财务上都不存在问题。俄中两国能够在组建联合空间站上进行很好的合作。"}];
    
    [self.dataArray addObject:@{@"content":@"中国宣布将在2022年建成空间站。中国将于2020年左右建成的空间站，将成为中国空间科学和新技术研究实验的重要基地，在轨运营10年以上。中国载人航天工程第三步的空间站建设，初期将建造三个舱段，包括一个核心舱和两个实验舱，每个规模20多吨。基本构型为T字形，核心舱居中，实验舱Ⅰ和实验舱Ⅱ分别连接于两侧。随后，空间站运营期间，最多的时候，将有一艘货运飞船、两艘载人飞船。"}];
    
    self.statusArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", @"0",@"0",nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshPage
{
    if (isLoadCard) {
        NSLog(@"展示卡片");
        isLoadCard = NO;
        [self.tableView.mj_header endRefreshing];
    } else {
        NSLog(@"刷新执行start");
        [UIView animateWithDuration:0 delay:3.0f options:0 animations:^{
            
            NSLog(@"刷新执行end");
            [self.tableView.mj_header endRefreshing];
        }completion:nil];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArray[indexPath.row];
    return [self getReadMoreCellHeightWithTableView:tableView content:dic[@"content"] isExpand:[self.statusArray[indexPath.row] boolValue]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *dic = self.dataArray[indexPath.row];
    HFReadMoreCell *cell = [self setReadMoreCellTableView:tableView atIndexPath:indexPath content:dic[@"content"] isExpand:[self.statusArray[indexPath.row] boolValue]];
    return cell;

    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

//HFReadMoreCell

- (CGFloat)getReadMoreCellHeightWithTableView:(UITableView *)tableView content:(NSString *)content isExpand:(BOOL)isExpand
{
    return [HFReadMoreCell getCellHeight:content isExpand:isExpand];
}

- (HFReadMoreCell *)setReadMoreCellTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath content:(NSString *)content isExpand:(BOOL)isExpand
{
    HFReadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:kHFReadMoreCellID forIndexPath:indexPath];
    [cell setUpdateStatus:^(id sender) {
        NSLog(@"%ld",indexPath.row);
        self.statusArray[indexPath.row] = @"1";
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [cell setContent:content isExpand:isExpand];
    return cell;
}


#pragma mark - setter/getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        HFRefreshGifHeader *header = [HFRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshPage)];
        _tableView.mj_header = header;
        
        //下拉方法 拿到 contentOffset 偏移量 根据偏移量的不同 触发相应方法
        [header setScrollViewBlock:^(id sender) {
            CGFloat contentOffsetY = [sender floatValue];
            if (!isLoadCard && ![self.tableView.mj_header isRefreshing] && contentOffsetY < - 150) {
                NSLog(@"contentOffset %f",  contentOffsetY);
                isLoadCard = YES;
            }
        }];
        
        [_tableView registerClass:[HFReadMoreCell class] forCellReuseIdentifier:kHFReadMoreCellID];
    }
    return  _tableView;
}


@end
