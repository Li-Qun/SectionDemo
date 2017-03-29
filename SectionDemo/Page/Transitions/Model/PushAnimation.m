//
//  PushAnimation.m
//  ViewControllerTransitions
//
//  Created by Jymn_Chen on 14-2-6.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import "PushAnimation.h"

@implementation PushAnimation

#pragma mark - UIViewControllerAnimatedTransitioning Delegate

/* 动画切换的持续时间，以秒为单位 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.5;
}

/* 动画的内容 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    
    UIView * containerView = transitionContext.containerView;
    
    CGRect bounds = UIScreen.mainScreen.bounds;
    
    toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, - bounds.size.height);
    //Add the to- view
    [containerView addSubview:toViewController.view];
    
    //
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveLinear   animations:^{
        fromViewController.view.alpha = 0.5;
        toViewController.view.frame = finalFrameForVC;
        
    } completion:^(BOOL finished) {
        
        //Set the final position of every elements transformed
        [transitionContext completeTransition:YES];
        fromViewController.view.alpha = 1.0;
        
    }];
}

@end
