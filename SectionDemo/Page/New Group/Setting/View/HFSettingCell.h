//
//  HFSettingCell.h
//  SectionDemo
//
//  Created by HF on 2017/7/19.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kHFSettingCellId;

@interface HFSettingCell : UITableViewCell

- (void)setCellTitle:(NSString *)title content:(NSString *)content;

+ (CGFloat)getCellHeight;

@end
