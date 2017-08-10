//
//  HFSettingItem.h
//  SectionDemo
//
//  Created by HF on 2017/7/19.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFSettingItem : NSObject

@property (nonatomic, strong) NSString *icon; //左边图标
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content; // 描述
//具体样式的设置 如果格式不复杂 可区分成枚举Type 归类UI形式 这里UI有点复杂 不用Type
@property (nonatomic, strong) NSNumber *isRedPointHidden; //代表当前是否未读
@property (nonatomic, strong) NSNumber *isLineHidden;  //是否展示底部线
@property (nonatomic, strong) NSNumber *isArrowHidden; //是否展示箭头
/** cell上相关的触发事件 */
@property (nonatomic, copy) void (^operation)() ; // 点击cell后要执行的操作

/**
 创建通用 settingItem

 @param icon 左边图标
 @param title title
 @param content content
 @return item
 */
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title content:(NSString *)content;

@end
