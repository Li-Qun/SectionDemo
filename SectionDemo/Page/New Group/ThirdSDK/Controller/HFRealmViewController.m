//
//  HFRealmViewController.m
//  SectionDemo
//
//  Created by HF on 2017/7/6.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFRealmViewController.h"
#import "HFDatabase.h"
#import "HFUser.h"

@interface HFRealmViewController ()

@end

@implementation HFRealmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    return;
    [HFDatabase creatDataBaseWithName:@"demoTable1"];
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
    
    HFUser *user = [[HFUser alloc]init];
    [user creatUserWithUid:@"1231" name:@"哈哈"];
    
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        RLMRealm *realm = [RLMRealm defaultRealm];
//        [realm transactionWithBlock:^{
//            [realm addObject: Car];
//        }];
//    });
    
    HFUser *firstUser = [HFUser findUserWithUid:@"123"];
    NSLog(@"%@",firstUser);
    
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
