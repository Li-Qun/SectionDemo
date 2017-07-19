//
//  UIButton+Block.m
//  SectionDemo
//
//  Created by HF on 2017/7/13.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static const char btnKey;
@implementation UIButton (Block)

- (void)handelWithBlock:(btnBlock)block {

    if (block) {
        objc_setAssociatedObject(self,&btnKey , block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)btnAction:(id)sender
{
    btnBlock block = objc_getAssociatedObject(self,&btnKey);
    if (block) {
        block(sender);
    }
}

- (void)function:(id)sender
{
    objc_getAssociatedObject(self,_cmd);
}

@end
