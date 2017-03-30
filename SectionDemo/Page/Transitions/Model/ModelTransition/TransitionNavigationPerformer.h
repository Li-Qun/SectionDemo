//
//  TransitionNavigationPerformer.h
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TransitionPushAnimation;
@class TransitionPopAnimation;

@interface TransitionNavigationPerformer : NSObject <UINavigationControllerDelegate>

- (instancetype)initWithNav:(id)nav;

@property (weak, nonatomic)  UINavigationController *navigationController;

@property (strong, nonatomic) TransitionPushAnimation *pushAnimation;

@property (strong, nonatomic) TransitionPopAnimation *popAnimation;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end
