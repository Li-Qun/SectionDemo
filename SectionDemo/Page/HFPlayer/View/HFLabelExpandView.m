//
//  HFLabelExpandView.m
//  dailylife
//
//  Created by HF on 17/4/5.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import "HFLabelExpandView.h"

@implementation HFLabelExpandView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    content = @"河北新闻网4月4日讯（记者郭东）4月1日，中央决定设立河北雄安新区消息发布后，一些房地产中介和部分外地人员涌向雄安新区进行炒房，造成房价“虚高”、道路拥堵等问题。";
    
}

- (void)initView
{
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.label.backgroundColor = [UIColor greenColor];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [UILabel new];
    }
    return _label;
}

@end
