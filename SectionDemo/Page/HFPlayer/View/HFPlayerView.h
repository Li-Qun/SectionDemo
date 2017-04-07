//
//  HFPlayerView.h
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol EveryFrameDelegate <NSObject>
//点击一下屏幕 暂停
- (void)oneTouchTipPause;
//是快进 还是 快退
- (void)touchRetreatOrTouchspeedWith:(BOOL)isTouchspeed;
@end

@interface HFPlayerView : UIView
{
    float x;
    float y;
    float volume;
    __unsafe_unretained id    delegate;
}
@property(nonatomic,retain) AVPlayer *player;
@property(nonatomic,assign) float     volume;
@property (nonatomic,assign) id      delegate;

@end
