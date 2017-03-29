//
//  PopAnimation.m
//  ViewControllerTransitions
//
//  Created by Jymn_Chen on 14-2-6.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import "PopAnimation.h"

@implementation PopAnimation

#pragma mark - UIViewControllerAnimatedTransitioning Delegate

/* 动画切换的持续时间，以秒为单位 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 2;
}

/* 动画的内容 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController * toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrameForVC = [transitionContext finalFrameForViewController:toViewController];
    
    UIView * containerView = transitionContext.containerView;
    
    toViewController.view.frame = finalFrameForVC;
    toViewController.view.alpha = 0.5;
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    UIView * snapshotView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = fromViewController.view.frame;
    [containerView addSubview:snapshotView];
    fromViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapshotView.frame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width / 2, fromViewController.view.frame.size.height / 2);
        toViewController.view.alpha = 1.0;
    } completion:^(BOOL finished) {
        
        [snapshotView removeFromSuperview];
        if ([transitionContext transitionWasCancelled]) {
            fromViewController.view.alpha = 1.0;
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];

}

@end
