
//
//  HFSettingCell.m
//  SectionDemo
//
//  Created by HF on 2017/7/19.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

NSString *const kHFSettingCellId = @"kHFSettingCellId";

#import "HFSettingCell.h"

@interface HFSettingCell ()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *contentLabel;

@end

@implementation HFSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        //[self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self initView];
    }
    return self;
}

- (void)initView
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.right.equalTo(self.contentView).offset(- 15);
        make.centerY.equalTo(self.contentView);
    }];
}

- (void)setCellTitle:(NSString *)title content:(NSString *)content
{
    self.titleLabel.text = title;
    self.contentLabel.text = content;
}

+ (CGFloat)getCellHeight
{
    return 49;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentLabel;
}

@end
