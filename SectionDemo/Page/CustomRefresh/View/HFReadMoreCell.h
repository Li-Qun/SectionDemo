//
//  HFReadMoreCell.h
//  dailylife
//
//  Created by HF on 17/4/6.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN  NSString * const kHFReadMoreCellID;

@interface HFReadMoreCell : UITableViewCell

- (void)setContent:(NSString *)content isExpand:(BOOL)isExpand;

@property (nonatomic, copy) void(^updateStatus)(id sender);

+ (CGFloat)getCellHeight:(NSString *)content isExpand:(BOOL)isExpand;

@end
