//
//  TransitionCell.m
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TransitionCell.h"

@interface TransitionCell ()

@end


@implementation TransitionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
//    [self.contentView addSubview:self.titleLabel];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.bottom.equalTo(self.contentView);
//        make.width.equalTo(@100);
//    }];
//    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.width.equalTo(@100);
      
    }];
}

#pragma mark - setter/getter

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"我是荷花";
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.jpg"]];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

@end
