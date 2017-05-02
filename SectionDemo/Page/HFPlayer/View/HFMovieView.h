//
//  HFMovieView.h
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFPlayerView.h"

typedef NS_ENUM(NSUInteger, MovieViewState) {
    MovieViewStateSmall,
    MovieViewStateAnimating,
    MovieViewStateFullscreen,
};

@interface HFMovieView : UIView

/**
 视频播放对象
 */
@property (nonatomic, strong)HFPlayerView *videoView;

/**
 记录小屏时的parentView
 */
@property (nonatomic, weak) UIView *movieViewParentView;

/**
 记录小屏时的frame
 */
@property (nonatomic, assign) CGRect movieViewFrame;

@property (nonatomic, assign) MovieViewState state;


/**
 video 菜单按钮
 */
@property (nonatomic, strong)UIButton *playVideoBtn;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)NSString *videoTitle;


/**
 *  视频加载失败处理
 */
- (void)videoFailedToPrepareForPlayer;


/**
 更新视频 UI状态

 @param isPlay isPlay
 */
- (void)setVideoPlayUIStatus:(BOOL)isPlay;

@end
