//
//  WKDelegateController.m
//  SectionDemo
//
//  Created by HF on 2017/6/22.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "WKDelegateController.h"

@interface WKDelegateController ()

@end

@implementation WKDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}
@end
