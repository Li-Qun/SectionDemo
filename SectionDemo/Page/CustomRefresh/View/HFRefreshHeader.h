//
//  HFRefreshHeader.h
//  SectionDemo
//
//  Created by HF on 17/3/30.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>

@interface HFRefreshHeader : MJRefreshComponent

/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

/** 文字距离圈圈、箭头的距离 */
@property (assign, nonatomic) CGFloat labelLeftInset;
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(MJRefreshState)state;

@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;



@end



/**
 刷新 头部展示动图
 */
@interface HFRefreshGifHeader : MJRefreshGifHeader


/** 创建header */
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
/** 创建header */
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action;

@property (nonatomic, copy) void(^scrollViewBlock)(id sender);

@end

