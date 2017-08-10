//
//  NavigationPerfomer.h
//  ViewControllerTransitions
//
//  Created by Jymn_Chen on 14-2-6.
//  Copyright (c) 2014年 Jymn_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PushAnimation;
@class PopAnimation;

@interface NavigationPerfomer : NSObject <UINavigationControllerDelegate>

- (instancetype)initWithNav:(id)nav;

@property (weak, nonatomic)  UINavigationController *navigationController;

@property (strong, nonatomic) PushAnimation *pushAnimation;

@property (strong, nonatomic) PopAnimation *popAnimation;

@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end
