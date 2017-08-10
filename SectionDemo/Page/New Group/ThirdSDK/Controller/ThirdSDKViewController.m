//
//  ThirdSDKViewController.m
//  SectionDemo
//
//  Created by HF on  2017/7/4.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "ThirdSDKViewController.h"
#import "TableViewCacheViewController.h"
#import "UIButton+Block.h"

@interface ThirdSDKViewController ()
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation ThirdSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)configSubviews
{
    [self.view addSubview:self.submitButton];
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(- 30);
        make.top.equalTo(self.view).offset(49 + 64);
        make.height.equalTo(@44);
    }];
}

#pragma mark - getter setter

- (UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"开始使用" forState:UIControlStateNormal];
        _submitButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitButton.layer.masksToBounds = YES;
        _submitButton.layer.cornerRadius = 2.0;
        //TODO:
        _submitButton.backgroundColor = [UIColor blackColor];
        
        __weak typeof(self) weakSelf = self;
        [_submitButton handelWithBlock:^(id sender) {
            
            TableViewCacheViewController *vc = [TableViewCacheViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _submitButton;
}
@end
