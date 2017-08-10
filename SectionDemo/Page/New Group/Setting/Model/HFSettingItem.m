//
//  HFSettingItem.m
//  SectionDemo
//
//  Created by HF on 2017/7/19.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFSettingItem.h"

@implementation HFSettingItem

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    HFSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.content = content;
    return item;
}

@end
