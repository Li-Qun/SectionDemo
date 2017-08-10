//
//  HFSettingGroup.h
//  SectionDemo
//
//  Created by HF on 2017/7/19.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFSettingGroup : NSObject

@property (nonatomic, strong) NSString *header; // 头部标题
@property (nonatomic, strong) NSString *footer; // 尾部标题
@property (nonatomic, strong) NSArray *items; // 中间的条目

@end
