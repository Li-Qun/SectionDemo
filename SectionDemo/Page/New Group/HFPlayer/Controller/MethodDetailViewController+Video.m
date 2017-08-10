//
//  MethodDetailViewController+Video.m
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "MethodDetailViewController+Video.h"
#import "HFNoteView.h"

@implementation MethodDetailViewController (Video)

#pragma mark - public method
#pragma mark -- 创建 视频 视图
- (void)createVideoHeaderView
{
    [self.headView addSubview:self.moviewView];
    [self.moviewView.playVideoBtn addTarget:self action:@selector(playVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self loadMethodVideo];
}

#pragma mark -- 取消设置的video监听
- (void)cancelVideoObservers
{
    if (self.moviewView.videoView.player && self.moviewView.videoView.player.currentItem) {
        @try{
            [self.moviewView.videoView.player.currentItem removeObserver:self forKeyPath:@"status" context:NULL];
        }@catch(id anException){
            NSLog(@"查无此监听对象");
        }
        @try{
            [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.moviewView.videoView.player.currentItem];
        }@catch(id anException){
            
        }
        self.moviewView.videoView.player = nil;
    }
}

#pragma mark - private method
#pragma mark -- 载入视频
- (void)loadMethodVideo
{
    //NSString *videoString = @"http://img.huofar.com/ia/method_vedio/DSCF7111-2.mp4";
    NSString *videoString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoString] options:nil];
    NSArray *keys = [NSArray arrayWithObject:@"playable"];
    [asset loadValuesAsynchronouslyForKeys:keys completionHandler:
     ^{//observer first :创建或重新创建 需要先release旧的对象 再add
         dispatch_async( dispatch_get_main_queue(),
                        ^{
                            [self prepareToPlayAsset:asset withKeys:keys];
                        });
     }];
}

#pragma mark -- 调用keys 判断 加载是否成功 可用
- (void)prepareToPlayAsset:(AVURLAsset *)asset withKeys:(NSArray *)requestedKeys
{
    for (NSString *thisKey in requestedKeys) {
        NSError *error = nil;
        AVKeyValueStatus keyStatus = [asset statusOfValueForKey:thisKey error:&error];
        if (keyStatus == AVKeyValueStatusFailed) {
            [self assetFailedToPrepareForPlayer:error];
            return;
        }
    }
    
    if (!asset.playable)
    {
        NSString *localizedDescription = NSLocalizedString(@"Item cannot be played", @"Item cannot be played description");
        NSString *localizedFailureReason = NSLocalizedString(@"The assets tracks were loaded, but could not be made playable.", @"Item cannot be played failure reason");
        NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   localizedDescription, NSLocalizedDescriptionKey,
                                   localizedFailureReason, NSLocalizedFailureReasonErrorKey,
                                   nil];
        NSError *assetCannotBePlayedError = [NSError errorWithDomain:@"StitchedStreamPlayer" code:0 userInfo:errorDict];
        [self assetFailedToPrepareForPlayer:assetCannotBePlayedError];
        return;
    }
    [self cancelVideoObservers];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:[AVPlayerItem playerItemWithAsset:asset]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.moviewView.videoView.player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.moviewView.videoView setPlayer:player];
    
    //设置video的两个监听
    [self.moviewView.videoView.player.currentItem addObserver:self forKeyPath:@"status" options:0 context:NULL];//当前视频播放状态监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.moviewView.videoView.player.currentItem];//添加视频播放完成的notifation

}

#pragma mark -- 响应视频 从加载到可播放状态的监听

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            mediaStatusItem  = MediaStatusTypeReady;
        }else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerItemStatusUnknown) {
            mediaStatusItem  = MediaStatusTypeFail;
        }
        
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        // 计算缓冲进度
        mediaStatusItem  = MediaStatusTypeWaiting;
    }else{
        mediaStatusItem  = MediaStatusTypeFail;
        NSLog(@"其他错误 %@",keyPath);
    }
    NSError *error = [playerItem error];
    if([error code] != 0) {
        NSLog(@"%s %ld\n", __FUNCTION__, (long)[error code]);
        NSLog(@"AVPlayerStatusFailed  %ld视频加载失败 %@",(long)[playerItem status],error);
        [self assetFailedToPrepareForPlayer:error];
    }
}

#pragma mark -- 视频加载失败处理
- (void)assetFailedToPrepareForPlayer:(NSError *)error
{
    [self.moviewView videoFailedToPrepareForPlayer];
    [self cancelVideoObservers];
}

#pragma mark - event response

#pragma mark -- 响应视频播放完成的监听方法
-(void)moviePlayDidEnd:(NSNotification*)notification{
    //视频播放完成
    NSLog(@"播放完成 进入循环");
    AVPlayerItem * p = [notification object];
    //关键代码
    [p seekToTime:kCMTimeZero];//  coreMedia.framework
    [self.moviewView.videoView.player play];//要求循环播放
}

#pragma mark -- playVideoAction
- (void)playVideoAction:(id)sender
{
    if(mediaStatusItem  == MediaStatusTypeFail){//重新加载
        mediaStatusItem = MediaStatusTypeWaiting;
        [[[HFNoteView alloc] initShowContent:@"视频加载失败,正在重新加载中..."]show];
        [self loadMethodVideo];
        return;
    }
    if(mediaStatusItem  == MediaStatusTypeReady){//可以播放
        [self.moviewView.videoView.player play];
        [self.moviewView setVideoPlayUIStatus:YES];
    }
    if(mediaStatusItem == MediaStatusTypeWaiting){//正在缓冲
        [[[HFNoteView alloc] initShowContent:@"视频正在缓冲中..."]show];
    }
    if(mediaStatusItem == MediaStatusTypeUnKnown){
        [[[HFNoteView alloc] initShowContent:@"正在获取视频"]show];
        mediaStatusItem = MediaStatusTypeWaiting;
        [self loadMethodVideo];
    }
}

#pragma mark -- videoBackButtonAction:
- (void)videoBackButtonAction:(id)sender
{
    [self.moviewView.videoView.player pause];
    [self.moviewView setVideoPlayUIStatus:NO];
}

@end
