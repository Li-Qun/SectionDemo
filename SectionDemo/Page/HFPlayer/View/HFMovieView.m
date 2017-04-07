//
//  HFMovieView.m
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFMovieView.h"

@implementation HFMovieView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
         //videoView
        [self addSubview:self.videoView];
        
        //others
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [self.videoView addGestureRecognizer:tapGestureRecognizer];
    
    }
    return self;
}

#pragma mark - event

- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        if (self.state == MovieViewStateSmall) {
            [self enterFullscreen];
        }
        else if (self.state == MovieViewStateFullscreen) {
            [self exitFullscreen];
        }
    }
}

#pragma mark - private

#pragma mark -- 全屏 animation
- (void)enterFullscreen {
    
    if (self.state != MovieViewStateSmall) {
        return;
    }
    
    self.state = MovieViewStateAnimating;
    
    /*
     * 记录进入全屏前的parentView和frame
     */
    self.movieViewParentView = self.videoView.superview;
    self.movieViewFrame = self.videoView.frame;
    
    /*
     * movieView移到window上
     */
    CGRect rectInWindow = [self convertRect:self.videoView.bounds toView:[UIApplication sharedApplication].keyWindow];
    [self.videoView removeFromSuperview];
    self.videoView.frame = rectInWindow;
    [[UIApplication sharedApplication].keyWindow addSubview:self.videoView];
    
    /*
     * 执行动画
     */
    [UIView animateWithDuration:0.5 animations:^{
        self.videoView.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.videoView.bounds = CGRectMake(0, 0, CGRectGetHeight(self.videoView.superview.bounds), CGRectGetWidth(self.videoView.superview.bounds));
        self.videoView.center = CGPointMake(CGRectGetMidX(self.videoView.superview.bounds), CGRectGetMidY(self.videoView.superview.bounds));
    } completion:^(BOOL finished) {
        self.state = MovieViewStateFullscreen;
    }];
    
    [self refreshStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
}

#pragma mark -- 退出全屏 animation

- (void)exitFullscreen
{
    if (self.state != MovieViewStateFullscreen) {
        return;
    }
    
    self.state = MovieViewStateAnimating;
    
    CGRect frame = [self.movieViewParentView convertRect:self.movieViewFrame toView:[UIApplication sharedApplication].keyWindow];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.videoView.transform = CGAffineTransformIdentity;
        self.videoView.frame = frame;
    } completion:^(BOOL finished) {
        /*
         * movieView回到小屏位置
         */
        [self.videoView removeFromSuperview];
        self.videoView.frame = self.movieViewFrame;
        [self.movieViewParentView addSubview:self.videoView];
        self.state = MovieViewStateSmall;
    }];
    
    [self refreshStatusBarOrientation:UIInterfaceOrientationPortrait];
}


#pragma mark -- 更新状态栏方向

- (void)refreshStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:YES];
}


#pragma mark - setter and getter

- (HFPlayerView *)videoView
{
    if (!_videoView) {
        _videoView = [[HFPlayerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _videoView.backgroundColor = [UIColor blackColor];
    }
    return _videoView;
}


@end
