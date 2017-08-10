//
//  MethodDetailViewController.h
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFMovieView.h"

typedef NS_ENUM(NSInteger, MediaStatusType){//当前视频状态
    MediaStatusTypeUnKnown = 0,  ///未知媒体状态 请稍后再试
    MediaStatusTypeReady   = 1, //可以播放状态
    MediaStatusTypeFail    = 2, //加载失败
    MediaStatusTypeWaiting = 3  //正在缓冲加载
};


@interface MethodDetailViewController : UIViewController
{
    MediaStatusType mediaStatusItem;
}
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) HFMovieView *moviewView;

@end
