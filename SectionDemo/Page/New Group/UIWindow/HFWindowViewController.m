//
//  HFWindowViewController.m
//  SectionDemo
//
//  Created by HF on 2017/5/25.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFWindowViewController.h"

@interface HFWindowViewController ()

// 创建属性
@property (nonatomic, strong)UIWindow *myWindow1;

@end

@implementation HFWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建测试按钮
    UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    tempBtn.frame = CGRectMake(15,64, self.view.frame.size.width - 15 * 2, 64);
    [tempBtn setTitle:@"点我创建一个window" forState:UIControlStateNormal];
    // 通过按钮的点击事件生成不同windowLevel级别的window
    [tempBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tempBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- event

- (void)clickBtn:(id)sender
{
    [self test1];
}

- (void)clickWindowBtn:(id)sender
{
    //window 销毁
    self.myWindow1.hidden = YES; //可有可无 看 UI效果
    self.myWindow1 = nil; // 这个方法是真正移除 UIWindow
}

#pragma mark - private

/**
 *  这个方法证明两个问题
 *1、创建 window 不用添加到任何的控件上面，直接创建完毕 即自动添加到window 上
 *2、创建一个比默认window的windowLevel大的window来看一下什么效果，效果是会盖在原来的window上面
 */
- (void)test1
{
    // 创建window
    if (self.myWindow1 == nil) {

        if (IOS9) {
            self.myWindow1 =  [UIWindow new]; // 以后 默认了 window的大小
        } else {
            self.myWindow1 =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//这么写在哪个版本系统上，一点毛病都没有
        }
        
        UIButton *windowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [windowBtn setTitle:@"点我 销毁黄色 window" forState:UIControlStateNormal];
        windowBtn.backgroundColor = [UIColor redColor];
        windowBtn.frame = CGRectMake(15, 64, self.view.frame.size.width - 15 * 2, 64);
        [windowBtn addTarget:self action:@selector(clickWindowBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.myWindow1 addSubview:windowBtn];
        
    }
    // 设置window的颜色，这里设置成黄色，方便查看window的层级关系
    self.myWindow1.backgroundColor = [UIColor yellowColor];
    // 设置 window 的 windowLevel
    self.myWindow1.windowLevel = UIWindowLevelStatusBar; //TODO: Normal，StatusBar，Alert 分别 为 0，1000，2000 可以修改这里体验 层级变化 对 展示 window的影响
    self.myWindow1.hidden = NO;
    [self.myWindow1  makeKeyAndVisible]; //成为keyWindow
}

@end
