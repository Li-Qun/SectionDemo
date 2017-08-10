//
//  HFMovieView.m
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFMovieView.h"
#import "UIView+GoAdd.h"

#import "VideoSlider.h"
#import "VideoProgressive.h"
#import "MethdDetailVideoMaskImageView.h"
#import "MethodDetailVideoToolBarView.h"

@interface HFMovieView ()
{
    id timeObserver;
    float restoreAfterScrubbingRate;
    BOOL isSeeking;//判断 是否正在拖动进度
    BOOL isHandlePause; //手动暂停
    BOOL isShowToolBar;//是否隐藏工具菜单
}
@property (nonatomic, strong)MethodDetailVideoToolBarView *toolBarView;//工具视图
@property (nonatomic, strong)VideoProgressive *progressiveView; //缓冲进度
@property (nonatomic, strong)VideoSlider *movieProgressSlider;   //播放进度
@property (nonatomic, strong)UILabel *leftTimeLabel;          //左边展示动态变化时间
@property (nonatomic, strong)UILabel *rightTimeLabel;         //右边展示视频播放总时间
@property (nonatomic, assign)CGFloat totalMovieDuration;      //视频播放总时间
@property (nonatomic, strong)UIButton *pauseButton;           //随时暂停按钮
@property (nonatomic, strong)UIButton *fullScreenButton;      //全屏按钮
@property (nonatomic, strong)UIImageView *videoLoadingView;   //视频卡住时候 展示loading图标
@property (nonatomic, strong)MethdDetailVideoMaskImageView *videoMaskImageView;//视频遮罩图

@end

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
        ////////////
        
        [self.videoView addSubview:self.playVideoBtn];
         self.playVideoBtn.center = self.videoView.center;
        [self initMenuView];
        

    }
    return self;
}

#pragma mark --- 更新 Slider状态
- (void)enableSlider
{
    self.movieProgressSlider.enabled = YES;
}

- (void)disableSlider
{
    self.movieProgressSlider.enabled = NO;
}

#pragma mark --- 取消以前注册的观察者
- (void)removePlayerTimeObserver
{
    if (timeObserver) {
        @try{
            [self.videoView.player removeTimeObserver:timeObserver];
            timeObserver = nil;
        }@catch(id anException){
            
        }
    }
}

#pragma mark - protect

#pragma mark -- 视频播放状态UI

- (void)setVideoPlayUIStatus:(BOOL)isPlay
{
    if (isPlay) {
        self.toolBarView.isAccepted = YES;
        self.pauseButton.selected = YES;
        
        [self enableSlider];
        [self initScrubberTimer];
    //TODO:
//        [self setToolBarsAlpha:0];
        isShowToolBar = YES;
        [self.videoView.player seekToTime:kCMTimeZero];//需求 每次都从头播放
        
    } else {
        self.videoView.layer.masksToBounds = YES;
        [self removePlayerTimeObserver];
        [self disableSlider];
        if ([self isPlaying]) {
            [self.videoView.player pause];
        }
        
        [self.videoLoadingView setHidden:YES];
    }
    BOOL isHidden = isPlay;
    [self.playVideoBtn setHidden:isHidden];
    [self.backBtn setHidden:!isHidden];
    [self.toolBarView setHidden:!isHidden];
    [self.movieProgressSlider setHidden:self.toolBarView.hidden];
}

#pragma mark -- 视频加载失败处理

- (void)videoFailedToPrepareForPlayer
{
    [self removePlayerTimeObserver];
    [self syncScrubber];
    [self disableSlider];
}

#pragma mark - event

- (void)handleTapGesture:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
//        if (self.state == MovieViewStateSmall) {
//            [self enterFullscreen];
//        }
//        else
        if (self.state == MovieViewStateFullscreen) {
            [self exitFullscreen];
        }
    }
}

- (void)fullScreenButtonAction:(id)sender
{
    if (self.state == MovieViewStateSmall) {
        self.fullScreenButton.selected = YES;
        [self enterFullscreen];
    }
    else if (self.state == MovieViewStateFullscreen) {
        self.fullScreenButton.selected = NO;
        [self exitFullscreen];
    }
}

- (void)pauseButtonAction:(id)sender
{
    if (self.pauseButton.selected) {
        [_pauseButton setTitle:@"已暂停" forState:UIControlStateNormal];
        [self.videoView.player pause];
    } else {
        [self.videoView.player play];
    }
    self.pauseButton.selected = !self.pauseButton.selected;
}

#pragma mark -- 拖动改变视频播放进度

- (void)movieProgressDragged:(id)sender
{
    //TODO:
    //[self isPlaying];
    if ([sender isKindOfClass:[UISlider class]] && !isSeeking) {
        isSeeking = YES;
        UISlider *slider = sender;
        
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration)) {
            [self showLeftLabelTimeToRightLabelTime:0.0 end:0.0];
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        if (isfinite(duration))
        {
            float minValue = [slider minimumValue];
            float maxValue = [slider maximumValue];
            float value = [slider value];
            
            float time = duration * (value - minValue) / (maxValue - minValue);
            [self showLeftLabelTimeToRightLabelTime:time end:duration];
            
            [self.videoView.player  seekToTime: CMTimeMakeWithSeconds(time, NSEC_PER_SEC)
                               toleranceBefore: kCMTimeZero
                                toleranceAfter: kCMTimeZero
                             completionHandler: ^(BOOL finished) {
                                 
                                 isSeeking = NO;
                                 isShowToolBar = NO;
                                 [self endSliderDragged:sender];
                                 [self performSelector:@selector(delayTheToolBarStatus:) withObject:nil afterDelay:4.0];
                             }];
        }
    }

}

- (void)beginSliderDragged:(id)sender
{
    restoreAfterScrubbingRate = [self.videoView.player rate];
    [self.videoView.player setRate:0.f];
    isShowToolBar = YES;
    [self setToolBarsAlpha:1.0];
    
    /* Remove previous timer. */
    [self removePlayerTimeObserver];
}

#pragma mark -- 当用户停止拖拽slider 时候 处理视频
- (void)endSliderDragged:(id)sender
{
    if (!timeObserver) {
        UISlider *slider = sender;
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration))
        {
            [self showLeftLabelTimeToRightLabelTime:0.0 end:0.0];
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        if (isfinite(duration))
        {
            CGFloat width = CGRectGetWidth([slider bounds]);
            double tolerance = 0.5f * duration / width;
            
            __weak typeof(self) weakSelf = self;
            timeObserver = [self.videoView.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(tolerance, NSEC_PER_SEC) queue:NULL usingBlock:
                            ^(CMTime time)
                            {
                                [weakSelf syncScrubber];
                            }];
        }
    }
    
    if (restoreAfterScrubbingRate) {
        [self.videoView.player setRate:restoreAfterScrubbingRate];
        restoreAfterScrubbingRate = 0.f;
    }

}

#pragma mark --
- (void)delayTheToolBarStatus:(id)sender
{
    if(!isShowToolBar){
        [UIView animateWithDuration:0.3 animations:^{
            if (isShowToolBar) return ;
            [self setToolBarsAlpha:0.0];
            isShowToolBar = YES;
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            if (!isShowToolBar) return ;
            [self setToolBarsAlpha:1.0];
            isShowToolBar = NO;
        }];
    }
}

#pragma mark - private

- (void)initMenuView
{
     self.toolBarView.backgroundColor = [UIColor clearColor];
     self.rightTimeLabel.backgroundColor = [UIColor clearColor];
     self.leftTimeLabel.backgroundColor = [UIColor clearColor];
    
    [self.videoView addSubview:self.toolBarView];
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.videoView);
    }];
    
    [self.toolBarView addSubview:self.leftTimeLabel];
    [self.toolBarView addSubview:self.rightTimeLabel];
    [self.toolBarView addSubview:self.progressiveView];
    [self.toolBarView addSubview:self.movieProgressSlider];
    [self.toolBarView addSubview:self.pauseButton];
    [self.toolBarView addSubview:self.fullScreenButton];
    
    [self.pauseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.toolBarView).offset(10);
        make.width.equalTo(@44);
        make.top.equalTo(self.toolBarView.mas_bottom).offset(- 64);
        make.height.equalTo(@64);
    }];
    
    [self.leftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pauseButton.mas_right).offset(5);
        make.top.equalTo(self.pauseButton.mas_top);
        make.height.equalTo(@64);
        make.width.equalTo(@46);
    }];
    
    [self.rightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.toolBarView.mas_right).offset(- 35 - 46);
        make.top.equalTo(self.toolBarView.mas_bottom).offset(- 64);
        make.height.equalTo(@64);
        make.width.equalTo(@46);
    }];
    
    [self.progressiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTimeLabel.mas_right).offset(5);
        make.right.equalTo(self.rightTimeLabel.mas_left).offset(- 5);
        make.height.equalTo(@4);
        make.centerY.equalTo(self.leftTimeLabel);
    }];
    
    [self.movieProgressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.progressiveView);
    }];
    
    [self.fullScreenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightTimeLabel.mas_right);
        make.top.bottom.equalTo(self.rightTimeLabel);
        make.right.equalTo(self.toolBarView);
    }];

    self.toolBarView.hidden = NO;
}

#pragma mark -- 设置菜单透明度

- (void)setToolBarsAlpha:(CGFloat)alpha
{
    __weak typeof(self) weakSelf = self;
    weakSelf.toolBarView.alpha = alpha;
    weakSelf.movieProgressSlider.alpha = alpha;
}

#pragma mark -- 获取当前音乐状态 播放 还是暂停
- (BOOL)isPlaying
{
    BOOL isFlag = restoreAfterScrubbingRate != 0.f || [self.videoView.player rate] != 0.f;
    //TODO:
//    if (!isHandlePause) {
//        [self.videoLoadingView setHidden:isFlag];
//    }
    return isFlag;
}


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
        [self updateChildViewStatus:MovieViewStateFullscreen];
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
        
        [self updateChildViewStatus:MovieViewStateSmall];
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

#pragma mark -- 旋转childView

- (void)updateChildViewStatus:(MovieViewState)statusType
{
    if (statusType == MovieViewStateSmall) {
        CGPoint newPoint = CGPointMake(self.videoView.center.x, self.videoView.center.y - 64);
        self.playVideoBtn.center = newPoint;
        
    } else if (statusType == MovieViewStateFullscreen) {
   
        CGPoint newPoint = CGPointMake(self.videoView.center.y, self.videoView.center.x);
        self.playVideoBtn.center = newPoint;
    }
}

#pragma mark -- 更新状态栏方向

- (void)refreshStatusBarOrientation:(UIInterfaceOrientation)interfaceOrientation {
    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:YES];
}

#pragma mark -- 视频进度相关方法

#pragma mark --- 在block中 更新调用媒体
-(void)initScrubberTimer
{
    [self removePlayerTimeObserver];
    
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)) {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration)) {
        CGFloat width = CGRectGetWidth([self.movieProgressSlider bounds]);
        interval = 0.5f * duration / width;
    }
    
    /* Update the slider during normal playback. */
    __weak typeof(self) weakSelf = self;
    timeObserver = [self.videoView.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)
                                                                       queue:NULL /* If you pass NULL, the main queue is used. */
                                                                  usingBlock:^(CMTime time)
                    {
                        [weakSelf syncScrubber];
                    }];
    
    [self enableSlider];
}


#pragma mark --- 基于用户当前设置的时间
- (void)syncScrubber
{
    //听哦懂:
   //if (!self.isFullScreen) return;
    
    //[self isPlaying];
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration)) {
        self.movieProgressSlider.minimumValue = 0.0;
        [self showLeftLabelTimeToRightLabelTime:0.0 end:0.0];
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration) && !isSeeking) {
        float minValue = [self.movieProgressSlider minimumValue];
        float maxValue = [self.movieProgressSlider maximumValue];
        float time = CMTimeGetSeconds([self.videoView.player currentTime]);
        [self showLeftLabelTimeToRightLabelTime:time end:duration];
        [self.movieProgressSlider setValue:(maxValue - minValue) * time / duration + minValue];
    }
    /*缓冲进度*/
    NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
    
    AVPlayerItem *playerItem = [self.videoView.player currentItem];
    CMTime duration11 = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration11);
    [self.progressiveView setProgress:timeInterval / totalDuration animated:YES];
    
}

#pragma mark ---  Get the duration for a AVPlayerItem.
- (CMTime)playerItemDuration
{
    AVPlayerItem *playerItem = [self.videoView.player currentItem];
    if (playerItem.status == AVPlayerItemStatusReadyToPlay) {
        return([playerItem duration]);
    }
    return(kCMTimeInvalid);
}

#pragma mark ---  计算缓冲进度

- (NSTimeInterval)availableDuration {
    NSArray *loadedTimeRanges = [[self.videoView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    
    return result;
}

#pragma mark --- 调整展示变化时间和结束时间
-(void)showLeftLabelTimeToRightLabelTime:(double)startime end:(double)endttime
{
    if (startime<=0) {
        [self.leftTimeLabel setText:@"00:00"];
    } else {
        
        int sec = startime/60;
        int mmin = (int)startime%60;
        if (sec<10 && mmin<10) {
            [self.leftTimeLabel setText:[NSString stringWithFormat:@"0%d:0%d",sec,mmin]];
        } else if (sec<10 && mmin>=10){
            [self.leftTimeLabel setText:[NSString stringWithFormat:@"0%d:%d",sec,mmin]];
        } else if (sec>=10 && mmin<10){
            [self.leftTimeLabel setText:[NSString stringWithFormat:@"%d:0%d",sec,mmin]];
        } else {
            [self.leftTimeLabel setText:[NSString stringWithFormat:@"%d:%d",sec,mmin]];
        }
    }
    
    if (endttime<=0) {
        [self.rightTimeLabel setText:@"00:00"];
    } else {
        
        int sec = endttime/60;
        int mmin = (int)endttime%60;
        
        if (sec<10 && mmin<10) {
            [self.rightTimeLabel setText:[NSString stringWithFormat:@"0%d:0%d",sec,mmin]];
        } else if (sec<10 && mmin>=10){
            [self.rightTimeLabel setText:[NSString stringWithFormat:@"0%d:%d",sec,mmin]];
        } else if (sec>=10 && mmin<10){
            [self.rightTimeLabel setText:[NSString stringWithFormat:@"%d:0%d",sec,mmin]];
        } else {
            [self.rightTimeLabel setText:[NSString stringWithFormat:@"%d:%d",sec,mmin]];
        }
    }
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

- (UIButton *)playVideoBtn
{
    if (!_playVideoBtn) {
        _playVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playVideoBtn setBackgroundImage:[UIImage imageNamed:@"icon_video_button_play"] forState:UIControlStateNormal];
        _playVideoBtn.hf_width = 84;
        _playVideoBtn.hf_height =  48;
    }
    return _playVideoBtn;
}

- (MethodDetailVideoToolBarView *)toolBarView
{
    if (!_toolBarView) {
        _toolBarView = [[MethodDetailVideoToolBarView alloc]initWithFrame:CGRectZero];
        _toolBarView.userInteractionEnabled = YES;
        [_toolBarView setHidden:YES];
    }
    return _toolBarView;
}

- (VideoSlider *)movieProgressSlider
{
    if (!_movieProgressSlider) {
        _movieProgressSlider = [[VideoSlider alloc]initWithFrame:CGRectZero];
        [_movieProgressSlider setMinimumTrackImage:[UIImage imageNamed:@"video_player_progressbar_highlighted"] forState:UIControlStateNormal];//已播放的颜色
        [_movieProgressSlider setMaximumTrackImage:[UIImage imageNamed:@"video_player_progressbar"] forState:UIControlStateNormal];//未播放部分颜色
        [_movieProgressSlider setThumbImage:[UIImage imageNamed:@"video_player_slider_present_point_active"] forState:UIControlStateHighlighted];
        [_movieProgressSlider setThumbImage:[UIImage imageNamed:@"video_player_slider_present_point"] forState:UIControlStateNormal];
        [_movieProgressSlider addTarget:self action:@selector(movieProgressDragged:) forControlEvents: UIControlEventTouchUpInside];
        [_movieProgressSlider addTarget:self action:@selector(beginSliderDragged:) forControlEvents: UIControlEventTouchDown];
        [_movieProgressSlider setHidden:YES];
    }
    return _movieProgressSlider;
}

- (VideoProgressive *)progressiveView
{
    if (!_progressiveView) {
        _progressiveView = [[VideoProgressive alloc]initWithFrame:CGRectZero];
        _progressiveView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4] ;
        _progressiveView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        
        UIImageView *progressTintImageView = [_progressiveView.subviews lastObject];
        if (progressTintImageView) {
            UIImage *image = [progressTintImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            progressTintImageView.image = image;
            progressTintImageView.tintColor = _progressiveView.progressTintColor;
        }
    }
    return _progressiveView;
}

- (UILabel *)leftTimeLabel
{
    if (!_leftTimeLabel) {
        _leftTimeLabel = [[UILabel alloc]initWithFrame: CGRectMake(0 ,0 , 46, 64)];
        _leftTimeLabel.textColor = [UIColor whiteColor];
        _leftTimeLabel.font = [UIFont systemFontOfSize:13.0];
        _leftTimeLabel.textAlignment = NSTextAlignmentCenter;
        _leftTimeLabel.text = @"00:00";
    }
    return _leftTimeLabel;
}

- (UILabel *)rightTimeLabel
{
    if (!_rightTimeLabel) {
        _rightTimeLabel = [[UILabel alloc]initWithFrame: CGRectMake(0 ,0 , 46, 64)];
        _rightTimeLabel.textColor = [UIColor whiteColor];
        _rightTimeLabel.font = [UIFont systemFontOfSize:13.0];
        _rightTimeLabel.textAlignment = NSTextAlignmentCenter;
        _rightTimeLabel.text = @"00:00";
    }
    return _rightTimeLabel;
}

- (MethdDetailVideoMaskImageView *)videoMaskImageView
{
    if (!_videoMaskImageView) {
        _videoMaskImageView = [[MethdDetailVideoMaskImageView alloc]initWithImage:[UIImage imageNamed: @"video_player_frame_bg" ]];
        _videoMaskImageView.frame = CGRectZero;
        _videoMaskImageView.userInteractionEnabled = YES;
    }
    return _videoMaskImageView;
}

- (UIButton *)pauseButton
{
    if (!_pauseButton) {
        _pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pauseButton setTitle:@"正播放" forState:UIControlStateSelected];
        [_pauseButton setTitle:@"未播放" forState:UIControlStateNormal];
         _pauseButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_pauseButton addTarget:self action:@selector(pauseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseButton;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
      //[_fullScreenButton setTitle:@"恢复" forState:UIControlStateSelected];
        [_fullScreenButton setTitle:@"全屏" forState:UIControlStateNormal];
        _fullScreenButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_fullScreenButton addTarget:self action:@selector(fullScreenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenButton;
}


@end
