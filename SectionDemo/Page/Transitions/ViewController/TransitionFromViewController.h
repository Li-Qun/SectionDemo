//
//  TransitionFromViewController.h
//  SectionDemo
//
//  Created by HF on 17/3/29.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionFromViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

- (id)tableViewCellForModel:(id)sender;

@end
