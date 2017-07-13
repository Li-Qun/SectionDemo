//
//  HFDatabase.h
//  SectionDemo
//
//  Created by HF on 2017/7/12.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 
 
 
 
 */

/**
 注意问题：
 1.跨线程访问数据库，Realm对象一定需要新建一个 不然会崩溃
      解决办法就是在当前线程重新获取最新的Realm
 2.transactionWithBlock 已经处于一个写的事务中，事务之间不能嵌套
     [realm transactionWithBlock:^{
     [self.realm beginWriteTransaction];
     [self convertToRLMUserWith:bhUser To:[self convertToRLMUserWith:bhUser To:nil]];
     [self.realm commitWriteTransaction];
     }];
     transactionWithBlock 已经处于一个写的事务中，如果还在block里面再写一个commitWriteTransaction，就会出错，写事务是不能嵌套的。
 3. 建议每个model都需要设置主键，这样可以方便add和update
    如果能设置主键，请尽量设置主键，因为这样方便我们更新数据，我们可以很方便的调用addOrUpdateObject:
    或者 createOrUpdateInRealm：withValue：方法进行更新。
    这样就不需要先根据主键，查询出数据，然后再去更新。有了主键以后，这两步操作可以一步完成。
 4. 查询也不能跨线程查询
 
         RLMResults * results = [self selectUserWithAccid:bhUser.accid];    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
 
         RLMRealm *realm = [RLMRealm defaultRealm];
         [realm transactionWithBlock:^{
         [realm addOrUpdateObject:results[0]];
         }];
         });
 */
@interface HFDatabase : NSObject


/**
 创建数据库 name

 @param databaseName 数据库名称
 */
+ (void)creatDataBaseWithName:(NSString *)databaseName;


/**
 更新数据库
 */
+ (void)updateDataBase;

@end
