//
//  HFUser.m
//  SectionDemo
//
//  Created by HF on 2017/7/12.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFUser.h"

@implementation HFUser
//重新设置主键
+ (NSString *)primaryKey {
    return @"uid";
}

/**
 存储数据 新建对象

 @param uid uid
 @param name name
 */
- (void)creatUserWithUid:(NSString *)uid name:(NSString *)name
{
    self.uid = uid;
    self.custName = name;
    self.avatarBig = @"";
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:self];
    [realm commitWriteTransaction];
}
+ (HFUser *)findUserWithUid:(NSString *)uid
{
    //从默认数据库查询所有的车RLMResults *cars = [Car allObjects];// 使用断言字符串查询
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"uid = '%@'",uid]];
    RLMResults *results = [HFUser objectsWithPredicate:pred];// 排序名字以“大”开头的棕黄色狗狗RLMResults *sortedDogs = [[Dog objectsWhere:@"color = '棕黄色' AND name BEGINSWITH '大'"] sortedResultsUsingProperty:@"name" ascending:YES];
    return results.firstObject;
    
    /*
    Realm还能支持链式查询
    
    Realm 查询引擎一个特性就是它能够通过非常小的事务开销来执行链式查询(chain queries)，而不需要像传统数据库那样为每个成功的查询创建一个不同的数据库服务器访问。
    
    RLMResults *Cars = [Car objectsWhere:@"color = blue"];
    RLMResults *CarsWithBNames = [Cars objectsWhere:@"name BEGINSWITH 'B'"];
     */
}

- (void)deleted
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    // 删除单条记录
   [realm deleteObject:self];
//    // 删除多条记录
//    [realm deleteObjects:CarResult];
//    // 删除所有记录
//    [realm deleteAllObjects];
//    //
    [realm commitWriteTransaction];
}


@end
