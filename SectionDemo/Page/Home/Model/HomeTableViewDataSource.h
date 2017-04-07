//
//  HomeTableViewDataSource.h
//  链式DSL学习
//
//  Created by HF on 17/3/8.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellBannerAction)(id sender);

typedef void (^TableViewCellDailyAction)(id sender);

typedef void (^TableViewCellListAction)(id sender);


@interface HomeTableViewDataSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) TableViewCellBannerAction banneryAction;
@property (nonatomic, copy) TableViewCellDailyAction dailyAction;
@property (nonatomic, copy) TableViewCellListAction listAction;

/**
 传入数据源

 @param anItems anItems
 @return anItems
 */
- (id)initWithItems:(NSArray *)anItems;

@end
