//
//  HomeBannerCell.m
//  dailylife
//
//  Created by HF on 17/2/21.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import "HomeBannerCell.h"

NSString * const kHomeBannerCellID = @"homeBannerCellID";

@interface HomeBannerCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation HomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setupViews];
    }
    return self;
}

#pragma mark - event response

#pragma mark - public methods

+ (CGFloat)getCellHeight
{
    return Round_VerticalFrom750(130);
}

- (void)setImageUrl:(NSString *)url
{
    __weak UIImageView *imageView = self.iconImageView;
    //[imageView hf_setImageWithUrl:[NSURL URLWithString:url] placeholderImage:nil];
}

#pragma mark - private

- (void)setupViews
{
   [self.contentView addSubview:self.iconImageView];
}

#pragma mark - getter and setter

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [HomeBannerCell getCellHeight
        ])];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.image = [UIImage imageNamed:@"timg.jpg"];
        
    }
    return _iconImageView;
}


@end
