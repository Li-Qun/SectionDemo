//
//  HFViewController.m
//  SectionDemo
//
//  Created by HF on 2017/7/14.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFViewController.h"
#import "TableViewCacheViewController.h"
#import "UIButton+Block.h"
@interface HFViewController ()

@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation HFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navBar];
    
    self.fd_prefersNavigationBarHidden = YES;
    
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
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//
- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [UINavigationBar new];
        _navBar.frame = CGRectMake(0, 0, self.view.hf_width, 64);
        _navBar.barTintColor = [UIColor whiteColor];
        [self.navBar pushNavigationItem:self.currentNavigationItem animated:NO];
    }
    return _navBar;
}

- (UIBarButtonItem *)leftItem
{
    if (!_leftItem) {
        _leftItem =  [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(back)];
    }
    return _leftItem;
}

- (UINavigationItem *)currentNavigationItem
{
    if (!_currentNavigationItem) {
        _currentNavigationItem = [[UINavigationItem alloc] initWithTitle:@"title"];
        _currentNavigationItem.leftBarButtonItem = self.leftItem;
        
    }
    return _currentNavigationItem;
}


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
