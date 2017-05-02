//
//  VideoProgressive.m
//  huofar
//
//  Created by HF on 16/4/25.
//
//

#import "VideoProgressive.h"

@implementation VideoProgressive

//需要处理 视频缓冲进度条高度 特此处理
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake(SCREEN_HEIGHT - 71 * 2, 4);
    return newSize;
}
@end
