//
//  TestViewController.m
//  SectionDemo
//
//  Created by HF on 2017/7/17.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (nonatomic, strong) UIView *theView;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor purpleColor];
    
    [self test];
}

- (void)test
{
    //实现背景渐变
    //初始化我们需要改变背景色的UIView，并添加在视图上
    self.theView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, self.view.hf_width)];
    [self.view addSubview:self.theView];
    //初始化CAGradientlayer对象，使它的大小为UIView的大小
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.theView.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [self.theView.layer addSublayer:self.gradientLayer];
    //设置渐变区域的起始和终止位置（范围为0-1）
   // self.gradientLayer.startPoint = CGPointMake(0, 0);
   // self.gradientLayer.endPoint = CGPointMake(1, 1);
    //设置颜色数组
    
    
    CGColorRef color1 = [UIColor colorWithWhite:1.000 alpha:0.7].CGColor;
    CGColorRef color2 = [UIColor colorWithWhite:1.000 alpha:0.0].CGColor;
    [_gradientLayer setColors:@[(__bridge id)color1,(__bridge id)color2]];
    
    //[_gradientLayer setFrame:[self bounds]];
  //  [[self layer] addSublayer:_gradientLayer];
    //self.gradientLayer.colors = @[(__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor clearColor].CGColor];
    //设置颜色分割点（范围：0-1）
    self.gradientLayer.locations = @[@(0.0f), @(0.9f)];
    
    
    
    //给渐变层设置 mask 属性
    {
        // 设置只显示一个三角形范围的渐变色
        UIBezierPath *shapeLayerPath = [[UIBezierPath alloc] init];
        // 点的坐标是相对于渐变层的
        [shapeLayerPath moveToPoint:CGPointMake(0,self.view.hf_width)];
        [shapeLayerPath addLineToPoint:CGPointMake(self.view.hf_width/2, 0)];
        [shapeLayerPath addLineToPoint:CGPointMake(self.view.hf_width, self.view.hf_width)];
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = shapeLayerPath.CGPath;
        
       self.gradientLayer.mask = shapeLayer;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
