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


@end
