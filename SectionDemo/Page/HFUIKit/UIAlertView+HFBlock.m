//
//  UIAlertView+HFBlock.m
//  SectionDemo
//
//  Created by HF on 2017/5/2.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "UIAlertView+HFBlock.h"
#import <objc/runtime.h>

@implementation UIAlertView (HFBlock)

- (void)setCompletionBlock:(HFAlertViewCompletionBlock)completionBlock {
    objc_setAssociatedObject(self, @selector(completionBlock), completionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (completionBlock == NULL) {
        self.delegate = nil;
    }
    else {
        self.delegate = self;
    }
}

- (HFAlertViewCompletionBlock)completionBlock {
    return objc_getAssociatedObject(self, @selector(completionBlock));
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (self.completionBlock) {
        self.completionBlock(self, buttonIndex);
    }
}
@end
