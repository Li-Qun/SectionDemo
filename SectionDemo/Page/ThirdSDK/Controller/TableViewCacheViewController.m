//
//  TableViewCacheViewController.m
//  SectionDemo
//
//  Created by HF on 2017/7/17.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TableViewCacheViewController.h"
#import "FreedomTextCell.h"
#import "HFChartLineCell.h"
#import "TestViewController.h"

@interface TableViewCacheViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    BOOL isLoadCard;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *statusArray;
@end


@implementation TableViewCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    NSLog(@"%@",_tableView);
    
    [self buildTableDataThen:^{
        [self.tableView reloadData];
    }];
}

- (void)buildTableDataThen:(void (^)(void))then
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //data from  array
        self.dataArray = [NSMutableArray array];
        [self.dataArray addObject:@{@"content":@"哈"}];
        [self.dataArray addObject:@{@"content":@"河北新闻网4月6日讯，近日，河北出入境检验检疫局京唐港办事处对一批来自荷兰的集装箱进行查验时，截获了象甲类昆虫，经专家鉴定为野豌豆叶象，为我国口岸首次发现。",@"isExpand": @"1"}];
        [self.dataArray addObject:@{@"content":@"网站4月5日报道，俄罗斯暗示放弃国际空间站，然后与中国共同建设一个基地",@"isExpand": @"1"}];
        [self.dataArray addObject:@{@"content":@"俄罗斯联邦太空局Roscosmos，正在考虑放弃让人类宇航员参与新的空间站，倾向于用机器人。"}];
        [self.dataArray addObject:@{@"content":@"加剧了俄罗斯和西方之间的紧张关系"}];
        
        [self.dataArray addObject:@{@"content":@"伊欧宁说，俄罗斯与中国可以建立这样的空间站，无论在技术上还是财务上都不存在问题。俄中两国能够在组建联合空间站上进行很好的合作。"}];
        
        [self.dataArray addObject:@{@"content":@"中国宣布将在2022年建成空间站。中国将于2020年左右建成的空间站，将成为中国空间科学和新技术研究实验的重要基地，在轨运营10年以上。中国载人航天工程第三步的空间站建设，初期将建造三个舱段，包括一个核心舱和两个实验舱，每个规模20多吨。基本构型为T字形，核心舱居中，实验舱Ⅰ和实验舱Ⅱ分别连接于两侧。随后，空间站运营期间，最多的时候，将有一艘货运飞船、两艘载人飞船。"}];
        [self.dataArray addObject:@{@"content":@"哈"}];
        [self.dataArray addObject:@{@"content":@"哈"}];
        [self.dataArray addObject:@{@"content":@"哈"}];
        [self.dataArray addObject:@{@"content":@"记者从武汉长江新城新闻发布会上了解到，武汉长江新城选址范围位于武汉中北部，起步区谌家矶——武湖区块：东至武湖泵河，南至长江北岸，西至滠水河、府河，西南至张公堤路，北至江北铁路，约30到50平方公里；中期发展区：100平方公里；远程控制区500平方公里。 长江新城总的目标和定位是：坚持世界眼光、国际标准、中国特色、高点定位，把长江新城建设成为践行新发展理念的典范之城。目前，长江新城起步区规划范围内，将实行针对规划土地、城市建设、房产管理、城市管理、户籍人口迁移和工商注册登记行为的“六管控”措施。"}];
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 0;
        //return self.dataArray.count;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [tableView fd_heightForCellWithIdentifier:kFreedomTextCellId cacheByIndexPath:indexPath configuration:^(FreedomTextCell *cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
    } else {
      return 45 *3 + 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0)  {
        FreedomTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kFreedomTextCellId]  ;
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    } else {
        HFChartLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kHFChartLineCellId] ;
        [cell configUI:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestViewController *vc = [TestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)configureCell:(FreedomTextCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //cell.fd_enforceFrameLayout = YES; // Enable to use "-sizeThatFits:" to set frame
    NSDictionary *dic = self.dataArray[indexPath.row];
    [cell setTitle:dic[@"content"]];
}

#pragma mark - setter/getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        
        [_tableView registerClass:[FreedomTextCell class] forCellReuseIdentifier:kFreedomTextCellId];
        [_tableView registerClass:[HFChartLineCell class] forCellReuseIdentifier:kHFChartLineCellId];
    }
    return  _tableView;
}

@end
