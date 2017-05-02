//
//  MethodDetailVideoToolBarView.m
//  huofar
//
//  Created by HF on 16/4/27.
//
//

#import "MethodDetailVideoToolBarView.h"

@implementation MethodDetailVideoToolBarView


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return self.isAccepted;
}

@end
