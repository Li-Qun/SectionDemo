//
//  UIAlertView+HFBlock.h
//  SectionDemo
//
//  Created by HF on 2017/5/2.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HFAlertViewCompletionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

@interface UIAlertView (HFBlock) <UIAlertViewDelegate>

- (void)setCompletionBlock:(HFAlertViewCompletionBlock)completionBlock;
- (HFAlertViewCompletionBlock)completionBlock;

@end
