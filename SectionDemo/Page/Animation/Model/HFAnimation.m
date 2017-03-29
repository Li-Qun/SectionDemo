//
//  HFAnimation.m
//  dailylife
//
//  Created by HF on 17/3/19.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import "HFAnimation.h"

@implementation HFAnimation

+(CATransition *)getShowAnimationIndex:(NSInteger)index fadeAnimationIndex:(NSInteger)fadeIndex
{
    CATransition *animation =[CATransition animation];
    animation.duration = 0.4;
     
    //新页面展示进入的效果
    switch (index) {
        case 1:
            animation.type = kCATransitionFade;//交叉淡化过渡
            break;
        case 2:
            animation.type = kCATransitionPush;  //新视图将旧视图推出去
            break;
        case 3:
            animation.type = kCATransitionReveal;  //底部显出来
            break;
        case 4:
            animation.type = kCATransitionMoveIn; //移动覆盖原图
            break;

        default:
            break;
    }
    
    //当前页面消失效果
    switch (fadeIndex) {
            
        case 0:
            animation.subtype = kCATransitionFromLeft;//(默认值)
            break;
        case 1:
            animation.subtype = kCATransitionFromBottom;
            break;
        case 2:
            animation.subtype = kCATransitionFromRight;
            break;
        case 3:
            animation.subtype = kCATransitionFromTop;
            break;
        default:
            break;
    }
    return animation;
}

@end
