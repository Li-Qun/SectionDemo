//
//  TransitionPushAnimation.m
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TransitionPushAnimation.h"
#import "TransitionFromViewController.h"
#import "TransitionToViewController.h"
#import "TransitionCell.h"

@implementation TransitionPushAnimation

#pragma mark - UIViewControllerAnimatedTransitioning Delegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

/* 动画的内容 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TransitionFromViewController *fromViewController = (TransitionFromViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionToViewController *toViewController = (TransitionToViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the thing cell we're transitioning from
    NSIndexPath *indexPath = [fromViewController.tableView indexPathForSelectedRow];
    TransitionCell *cell =(TransitionCell*) [fromViewController.tableView cellForRowAtIndexPath:indexPath];

    UIView *cellImageSnapshot = [cell.iconImageView snapshotViewAfterScreenUpdates:NO];
    cellImageSnapshot.frame = [containerView convertRect:cell.iconImageView.frame fromView:cell.iconImageView.superview];
    cell.iconImageView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    toViewController.iconImageView.hidden = YES;
    
    [containerView addSubview:toViewController.view];
    [containerView addSubview:cellImageSnapshot];

    [UIView animateWithDuration:duration animations:^{
        // Fade in the second view controller's view
        toViewController.view.alpha = 1.0;
        
        // Move the cell snapshot so it's over the second view controller's image view
        CGRect frame = [containerView convertRect:toViewController.iconImageView.frame fromView:toViewController.view];
        cellImageSnapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
        toViewController.iconImageView.hidden = NO;
        cell.hidden = NO;
        [cellImageSnapshot removeFromSuperview];
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


@end
