//
//  BrowserViewController.m
//  NSURLProtocolExample
//
//  Created by Rocir Marcos Leite Santiago on 11/29/13.
//  Copyright (c) 2013 Rocir Santiago. All rights reserved.
//

#import "BrowserViewController.h"

@interface BrowserViewController () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIButton *actionButton;
@end

@implementation BrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews
{
    [self.view addSubview:self.textField];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.actionButton];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@64);
        make.right.equalTo(self.view).offset(- 15 - 44);
        make.height.equalTo(@44);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.textField.mas_bottom);
    }];
    
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.textField);
        make.left.equalTo(self.textField.mas_right);
        make.right.equalTo(self.view);
    }];
}

#pragma mark - Action

- (void)buttonGoClicked:(id)sender {
    
    if ([self.textField isFirstResponder]) {
        [self.textField resignFirstResponder];
    }
    
    [self sendRequest];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self sendRequest];
    
    return YES;
}

#pragma mark - Private

- (void) sendRequest {
    
    NSString *text = self.textField.text;
    if (![text isEqualToString:@""]) {
        
        NSURL *url = [NSURL URLWithString:text];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

#pragma mark - setter getter

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        _textField.text = @"https://www.raywenderlich.com";
    }
    return _textField;
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setTitle:@"Go" forState:UIControlStateNormal];
        [_actionButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [_actionButton addTarget:self action:@selector(buttonGoClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

@end
