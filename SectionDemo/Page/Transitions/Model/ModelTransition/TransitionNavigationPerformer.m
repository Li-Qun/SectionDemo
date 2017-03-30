//
//  TransitionNavigationPerformer.m
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TransitionNavigationPerformer.h"
#import "TransitionPopAnimation.h"
#import "TransitionPushAnimation.h"

@interface TransitionNavigationPerformer ()
{
    UIScreenEdgePanGestureRecognizer *panGesture;
}

@end

@implementation TransitionNavigationPerformer

- (instancetype)initWithNav:(id)nav
{
    self = [super init];
    if (self) {
        
        self.navigationController = nav;
        // 在导航控制器的视图上添加pan手势 --> 需要从边缘进行拖动，在控制器转换的时候是有用 "UIScreenEdgePanGestureRecognizer"
        panGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        panGesture.edges = UIRectEdgeLeft; //主要用作返回 left
        [self.navigationController.view addGestureRecognizer:panGesture];
        
        // 初始化动画方案
        self.pushAnimation = [[TransitionPushAnimation alloc] init];
        self.popAnimation  = [[TransitionPopAnimation alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [panGesture removeTarget:self action:@selector(pan:)];
    self.interactionController = nil;
}

- (void)pan:(UIScreenEdgePanGestureRecognizer *)recognizer
{
    UIView *view = self.navigationController.view;
    CGFloat progress = [recognizer translationInView:view].x / (view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 创建过渡对象，弹出viewController
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // 更新 interactive transition 的进度
        [self.interactionController updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // 完成或者取消过渡
        if (progress > 0.5) {
            [self.interactionController finishInteractiveTransition];
        }
        else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

#pragma mark - UINavigationController Delegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return self.pushAnimation;
    }
    else if (operation == UINavigationControllerOperationPop) {
        return self.popAnimation;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // 检查是否是我们的自定义过渡
    if ([animationController isKindOfClass:[TransitionPushAnimation class]] || [animationController isKindOfClass:[TransitionPopAnimation class]]) {
        return self.interactionController;
    }
    else {
        return nil;
    }
}


@end
