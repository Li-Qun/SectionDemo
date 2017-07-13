//
//  HFDatabase.m
//  SectionDemo
//
//  Created by HF on 2017/7/12.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFDatabase.h"
#import "HFUser.h"
@implementation HFDatabase

+ (void)creatDataBaseWithName:(NSString *)databaseName
{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:databaseName];
    NSLog(@"数据库目录 = %@",filePath);
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    //config.objectClasses = @[MyClass.class, MyOtherClass.class];
    config.readOnly = NO;
    int currentVersion = 1.0;
    config.schemaVersion = currentVersion;
    
    config.migrationBlock = ^(RLMMigration *migration , uint64_t oldSchemaVersion) {       // 这里是设置数据迁移的block
        if (oldSchemaVersion < currentVersion) {
        }
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
}


+ (void)updateDataBase
{
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 2;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion)
    {    // enumerateObjects:block: 遍历了存储在 Realm 文件中的每一个“Person”对象
        [migration enumerateObjects:HFUser.className block:^(RLMObject *oldObject, RLMObject *newObject) {
            // 只有当 Realm 数据库的架构版本为 0 的时候，才添加 “fullName” 属性
            //(1)合并字段举例
            if (oldSchemaVersion < 1) {
                newObject[@"fullName"] = [NSString stringWithFormat:@"%@ %@", oldObject[@"firstName"], oldObject[@"lastName"]];
            }
            //(2)增加新字段:只有当 Realm 数据库的架构版本为 0 或者 1 的时候，才添加“email”属性
            if (oldSchemaVersion < 2) {
                newObject[@"email"] = @"";
            }
            // (3)替换属性名:是原字段重命名
            if (oldSchemaVersion < 3) { // 重命名操作应该在调用 `enumerateObjects:` 之外完成
                [migration renamePropertyForClass:HFUser.className oldName:@"yearsSinceBirth" newName:@"age"]; }
        }];
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];// 现在我们已经成功更新了架构版本并且提供了迁移闭包，打开旧有的 Realm 数据库会自动执行此数据迁移，然后成功进行访问[RLMRealm defaultRealm];
}

@end
