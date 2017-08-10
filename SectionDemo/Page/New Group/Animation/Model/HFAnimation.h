//
//  HFAnimation.h
//  dailylife
//
//  Created by HF on 17/3/19.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFAnimation : NSObject

//typedef enum : NSUInteger {
//    HFShowTypeFade = 1,
//    HFShowTypePush = 2,
//    HFShowTypeReveal = 3,
//    HFShowTypeMoveIn = 4
//} HFShowType;
//
//typedef enum : NSUInteger {
//    HFFadeTypeLeft = 0,
//    HFFadeTypeBottom = 1,
//    HFFadeTypeRight = 2,
//    HFFadeTypeTop = 3
//} HFFadeType;


/**
 新页面展示进入效果 当前页面退出效果

 @param index 进入效果索引
 @param fadeIndex 退出效果索引
 @return animation
 */
+(CATransition *)getShowAnimationIndex:(NSInteger)index
                    fadeAnimationIndex:(NSInteger)fadeIndex;

@end
