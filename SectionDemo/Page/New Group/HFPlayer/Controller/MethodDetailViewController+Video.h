//
//  MethodDetailViewController+Video.h
//  SectionDemo
//
//  Created by HF on 17/4/1.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "MethodDetailViewController.h"

@interface MethodDetailViewController (Video)


//创建 视频 视图
- (void)createVideoHeaderView;

//取消设置的video监听
- (void)cancelVideoObservers;

@end
