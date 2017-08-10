//
//  VideoSlider.m
//  huofar
//
//  Created by HF on 16/4/24.
//
//

#import "VideoSlider.h"

@implementation VideoSlider

//自定义 UISlider - Increase “hot spot(焦点区域)” size
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    CGRect bounds = self.bounds;
    bounds = CGRectInset(bounds, -10, -15);//左右扩宽 10 像素 上下扩宽 15像素
    return CGRectContainsPoint(bounds, point);
}

//需要处理 视频进度条高度 特此处理
//- (CGRect)trackRectForBounds:(CGRect)bounds {
//    return CGRectMake(0, 0, SCREEN_HEIGHT - 71 * 2, 4);
//}

@end
