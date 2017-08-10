//
//  HFReadMoreCell.m
//  dailylife
//
//  Created by HF on 17/4/6.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import "HFReadMoreCell.h"
#import <YYText/YYText.h>
#import "UIView+GoAdd.h"

NSString * const kHFReadMoreCellID = @"kHFReadMoreCellID";

@interface HFReadMoreCell ()

@property (nonatomic, strong) YYLabel *label;

@end


@implementation HFReadMoreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self initView];
    }
    return self;
}

- (void)setContent:(NSString *)content isExpand:(BOOL)isExpand
{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString: content];
    
    [text appendAttributedString:one];
    text.yy_font = [UIFont systemFontOfSize:14];
    text.yy_lineSpacing = 10;
    
    
    self.label.attributedText = text;
    self.label.numberOfLines = 0;
    [self.label sizeToFit];
    
    NSArray  *array = self.label.textLayout.lines;
    NSInteger count = array.count;
    if (count > 2 && !isExpand) {
        
        YYTextLine *line = array[2];
        NSInteger lastIndex =  line.range.location  > 7 ? line.range.location - 7 : line.range.location;
        NSRange range = NSMakeRange(0,lastIndex);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@...继续阅读",[text.string substringWithRange:range]]];
        
        [str yy_setTextHighlightRange:NSMakeRange(str.length - 4, 4)
                                color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
                      backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
                            tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                NSLog(@"好神奇");
                                if (self.updateStatus) {
                                    self.updateStatus(nil);
                                }
            
                            }];

        [str yy_setUnderlineStyle:NSUnderlineStyleSingle range:NSMakeRange(str.length - 4, 4)];
        str.yy_font = [UIFont systemFontOfSize:14];
        str.yy_lineSpacing = 10;
        self.label.attributedText = str;
        
    }
    self.label.userInteractionEnabled = YES;
    [self.label sizeToFit];
}

+ (CGFloat)getCellHeight:(NSString *)content isExpand:(BOOL)isExpand
{
    NSMutableAttributedString *text = [NSMutableAttributedString new];
    
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString: content];
    
    [text appendAttributedString:one];
    text.yy_font = [UIFont systemFontOfSize:14];
    text.yy_lineSpacing = 10;
    
    YYLabel *label = [YYLabel new];
    label.frame = CGRectMake(15, 20, SCREEN_WIDTH - 15 * 2, 30);
    label.attributedText = text;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    [label sizeToFit];
    
    NSArray  *array = label.textLayout.lines;
    NSInteger count = array.count;
    if (count > 2 && !isExpand) {
        YYTextLine *line = array[2];
        NSInteger lastIndex =  line.range.location  > 7 ? line.range.location - 7 : line.range.location;
        NSRange range = NSMakeRange(0,lastIndex);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@...继续阅读",[text.string substringWithRange:range]]];
        
        str.yy_font = [UIFont systemFontOfSize:14];
        str.yy_lineSpacing = 10;
        label.attributedText = str;
    }
    [label sizeToFit];
    return label.hf_height + 40;
}

- (void)initView
{
    [self.contentView addSubview:self.label];
    
    self.label.frame = CGRectMake(15, 20, SCREEN_WIDTH - 15 * 2, 30);
}


- (YYLabel *)label
{
    if (!_label) {
        _label = [YYLabel new];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
