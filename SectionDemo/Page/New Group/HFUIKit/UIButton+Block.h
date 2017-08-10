//
//  UIButton+Block.h
//  SectionDemo
//
//  Created by HF on 2017/7/13.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnBlock)(id sender);

@interface UIButton (Block)

- (void)handelWithBlock:(btnBlock)block;

@end
