//
//  HFChartLineCell.m
//  SectionDemo
//
//  Created by HF on 2017/7/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFChartLineCell.h"
#import "HFChart.h"

NSString *const kHFChartLineCellId = @"kHFChartLineCellId";

@interface HFChartLineCell () <HFChartDataSource>
{
    NSIndexPath *path;
    HFChart *chartView;
}

@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation HFChartLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self initView];
    }
    return self;
}

- (void)initView
{
    //none
}

- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[HFChart alloc]initWithFrame:CGRectMake(0, 0, 320, 45 *3 + 45)
                                   dataSource:self
                                        style:HFChartStyleLine];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [NSString stringWithFormat:@"12.2%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(HFChart *)chart
{
    return [self getXTitles:7];
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(HFChart *)chart
{
//    NSArray *ary = @[@"22",@"44",@"15",@"40",@"42"];
//    NSArray *ary1 = @[@"22",@"54",@"15",@"30",@"42",@"77",@"43"];
//    NSArray *ary2 = @[@"76",@"34",@"54",@"23",@"16",@"32",@"17"];
//    NSArray *ary3 = @[@"3",@"12",@"25",@"55",@"52"];
    NSArray *ary4 = @[@"90",@"30",@"60",@"100",@"90",@"60",@"30",@"30",@"60",@"90"];
    
    return @[ary4];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(HFChart *)chart
{
    return @[[UIColor colorWithRed:77.0/255.0 green:186.0/255.0 blue:122.0/255.0 alpha:1.0f]]; //绿色
}
//显示数值范围
- (CGRange)chartRange:(HFChart *)chart
{
    return CGRangeMake(100, 0);
//    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)chartHighlightRangeInLine:(HFChart *)chart
{
    if (path.row == 2) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)chart:(HFChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)chart:(HFChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return path.row == 2;
}

+ (CGFloat)getHeight
{
    return 45 * 3 + 45;
}

@end
