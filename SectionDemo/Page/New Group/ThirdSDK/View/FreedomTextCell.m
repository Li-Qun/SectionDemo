//
//  FreedomTextCell.m
//  SectionDemo
//
//  Created by HF on 2017/7/17.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "FreedomTextCell.h"

NSString *const kFreedomTextCellId = @"kFreedomTextCellId";

@interface FreedomTextCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FreedomTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
        make.right.bottom.equalTo(self.contentView).offset(- 15);
    }];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

//- (CGSize)sizeThatFits:(CGSize)size {
//    CGFloat totalHeight = 15;
//    totalHeight += [self.titleLabel sizeThatFits:size].height;
//         return CGSizeMake(size.width, totalHeight + 15);
//}

@end
