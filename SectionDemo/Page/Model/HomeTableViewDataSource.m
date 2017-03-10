//
//  HomeTableViewDataSource.m
//  链式DSL学习
//
//  Created by HF on 17/3/8.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HomeTableViewDataSource.h"
#import "HomeBannerCell.h"

typedef NS_ENUM(NSUInteger, HomeSectionType) {
    HomeSectionTypeBanner,   //banner
    HomeSectionTypeDaily,    //date
    HomeSectionTypeList     //List
};

@interface HomeTableViewDataSource ()
{
    NSMutableArray *sectionInfo;
}
@property (nonatomic, strong) NSArray *items;

@end

@implementation HomeTableViewDataSource

- (id)init
{
    return nil;
}

- (id)initWithItems:(NSArray *)anItems
{
    self = [super init];
    if (self) {
        sectionInfo = [NSMutableArray array];
        [sectionInfo addObject:@(HomeSectionTypeBanner)];
        [sectionInfo addObject:@(HomeSectionTypeDaily)];
        if (anItems.count > 0) {
            [sectionInfo addObject:@(HomeSectionTypeList)]; //list 列表
        }
        self.items = anItems;
        
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return sectionInfo.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (HomeSectionTypeBanner == [sectionInfo[section] integerValue]) {
        return 1;
    }
    if (HomeSectionTypeDaily == [sectionInfo[section] integerValue]) {
        return 1;
    }
    if (HomeSectionTypeList == [sectionInfo[section] integerValue]) {
        return self.items.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (HomeSectionTypeBanner == [sectionInfo[section] integerValue]) {
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeBannerCellID forIndexPath:indexPath];
        return cell;
    }
    if (HomeSectionTypeDaily == [sectionInfo[section] integerValue]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"
                                                                forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell;
    }
    if (HomeSectionTypeList == [sectionInfo[section] integerValue]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell"
                                                                forIndexPath:indexPath];
        id item = [self itemAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",item];
  
        return cell;
    }
    return [UITableViewCell new];
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (HomeSectionTypeBanner == [sectionInfo[section] integerValue]) {
        return [HomeBannerCell getCellHeight];
    }
    if (HomeSectionTypeDaily == [sectionInfo[section] integerValue]) {
        return 55;
    }
    if (HomeSectionTypeList == [sectionInfo[section] integerValue]) {
        return 44;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (HomeSectionTypeBanner == [sectionInfo[section] integerValue]) {
        if (self.banneryAction) {
            self.banneryAction(@"点击了banner");
        }
    }
    if (HomeSectionTypeDaily == [sectionInfo[section] integerValue]) {
        if (self.dailyAction) {
            self.dailyAction(@"点击了日期");
        }
    }
    if (HomeSectionTypeList == [sectionInfo[section] integerValue]) {
        if (self.listAction) {
            id item = [self itemAtIndexPath:indexPath];
            self.listAction([NSString stringWithFormat:@"点击了list单元 %@",item]);
        }
    }
}

@end
