//
//  HFUser.h
//  SectionDemo
//
//  Created by HF on 2017/7/12.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Realm/Realm.h>

@interface HFUser : RLMObject
//建一个新的 Realm 数据模型对象。对应在数据库里面就是一张表。
//官方不建议填写attributes属性(如nonatomic, atomic, strong, copy, weak 等等）这些attributes会一直生效直到RLMObject被写入realm数据库

@property NSString       *uid;//用户注册id
@property NSInteger      custId;//姓名
@property NSString       *custName;//头像大图url
@property NSString       *avatarBig;
//@property RLMArray *cars;

//增添
- (void)creatUserWithUid:(NSString *)uid name:(NSString *)name;

//查找
+ (HFUser *)findUserWithUid:(NSString *)uid;

//删除 一条
- (void)deleted;


@end
