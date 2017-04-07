//
//  HFPlayerView.m
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFPlayerView.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation HFPlayerView

@synthesize volume;
@synthesize delegate;

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (AVPlayer*)player
{
    return [(AVPlayerLayer*)[self layer]player];
}

- (void)setPlayer:(AVPlayer *)thePlayer
{
    return [(AVPlayerLayer*)[self layer]setPlayer:thePlayer];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"began %f==%f",touchPoint.x,touchPoint.y);
    x = (touchPoint.x);
    y = (touchPoint.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSLog(@"end %f==%f",touchPoint.x,touchPoint.y);
    
    if (touchPoint.y <= SCREEN_WIDTH - 64 && fabs (touchPoint.x - x) <= 5 && fabs (touchPoint.y - y) <= 5 ) {
        if ([delegate respondsToSelector:@selector(oneTouchTipPause)]) {
            [delegate oneTouchTipPause];
        }
    }
    return;
    
    if ((touchPoint.x - x) >= 50 && (touchPoint.y - y) <= 20 && (touchPoint.y - y) >= -20)
    {
        NSLog(@"快进");
        if ([delegate respondsToSelector:@selector(touchRetreatOrTouchspeedWith:)])
        {
            [delegate touchRetreatOrTouchspeedWith:YES];
        }
    }
    if ((touchPoint.x - x) >= 50 && (y - touchPoint.y) <= 50 && (y - touchPoint.y) >= -50)
    {
        NSLog(@"快进");
        if ([delegate respondsToSelector:@selector(touchRetreatOrTouchspeedWith:)])
        {
            [delegate touchRetreatOrTouchspeedWith:YES];
        }
    }
    if ((x - touchPoint.x) >= 50 && (touchPoint.y - y) <= 50 && (touchPoint.y - y) >= -50)
    {
        NSLog(@"快退");
        if ([delegate respondsToSelector:@selector(touchRetreatOrTouchspeedWith:)])
        {
            [delegate touchRetreatOrTouchspeedWith:NO];
        }
        
    }
    if ((x - touchPoint.x) >= 50 && (y - touchPoint.y) <= 50 && (y - touchPoint.y) >= -50)
    {
        NSLog(@"快退");
        if ([delegate respondsToSelector:@selector(touchRetreatOrTouchspeedWith:)])
        {
            [delegate touchRetreatOrTouchspeedWith:NO];
        }
        
    }
    if ((touchPoint.y - y) >= 50 && (touchPoint.x - x) <= 50 && (touchPoint.x - x) >= -50)
    {
        NSLog(@"减小音量 1/10");
        MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
        if ((mpc.volume - 0.1) <= 0)
        {
            mpc.volume = 0;
        }
        else
        {
            mpc.volume = mpc.volume - 0.05;
        }
    }
    if ((y - touchPoint.y) >= 50)
    {
        NSLog(@"加大音量");
        MPMusicPlayerController *mpc = [MPMusicPlayerController applicationMusicPlayer];
        if ((mpc.volume + 0.1) >= 1)
        {
            mpc.volume = 1;
        }
        else
        {
            mpc.volume = mpc.volume + 0.05;
        }
        
    }
}

@end
