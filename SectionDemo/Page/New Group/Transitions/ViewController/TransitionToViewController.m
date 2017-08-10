//
//  TransitionToViewController.m
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TransitionToViewController.h"
#import "TransitionNavigationPerformer.h"

@interface TransitionToViewController ()
{
    TransitionNavigationPerformer *navPerformer;
}

@end

@implementation TransitionToViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     navPerformer = [[TransitionNavigationPerformer alloc]initWithNav:self.navigationController];
    [self setupViews];
    self.title = @"详情";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.delegate = navPerformer;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViews
{
//    [self.view addSubview:self.titleLabel];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.width.equalTo(@100);
//        make.center.centerY.equalTo(self.view);
//    }];
    
    [self.view addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@200);
        make.center.equalTo(self.view);
    }];
    //更新childView frame
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
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
