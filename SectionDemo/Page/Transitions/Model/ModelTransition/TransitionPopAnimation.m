//
//  TransitionPopAnimation.m
//  
//
//  Created by HF on 17/3/29.
//
//

#import "TransitionPopAnimation.h"
#import "TransitionFromViewController.h"
#import "TransitionToViewController.h"
#import "TransitionCell.h"


@implementation TransitionPopAnimation

#pragma mark - UIViewControllerAnimatedTransitioning Delegate

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

/* 动画的内容 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    TransitionToViewController *fromViewController = (TransitionToViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    TransitionFromViewController *toViewController = (TransitionFromViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // Get a snapshot of the image view
    NSLog(@"%@",fromViewController.view.subviews);
    
    UIView *imageSnapshot = [fromViewController.iconImageView snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = [containerView convertRect:fromViewController.iconImageView.frame fromView:fromViewController.iconImageView.superview];
    fromViewController.iconImageView.hidden = YES;
    
    // Get the cell we'll animate to
    TransitionCell *cell =  [toViewController tableViewCellForModel:fromViewController.index];
    cell.iconImageView.hidden = YES;
    
    // Setup the initial view states
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    [containerView addSubview:imageSnapshot];
    
    
    [UIView animateWithDuration:duration animations:^{
        // Fade out the source view controller
        fromViewController.view.alpha = 0.0;
        
        // Move the image view
        imageSnapshot.frame = [containerView convertRect:cell.iconImageView.frame fromView:cell.iconImageView.superview];
    } completion:^(BOOL finished) {
        // Clean up
        [imageSnapshot removeFromSuperview];
        fromViewController.iconImageView.hidden = NO;
        cell.iconImageView.hidden = NO;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];



}

@end
