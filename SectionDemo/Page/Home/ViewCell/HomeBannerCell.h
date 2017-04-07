//
//  HomeBannerCell.h
//  dailylife
//
//  Created by HF on 17/2/21.
//  Copyright © 2017年 huofar. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN  NSString * const kHomeBannerCellID;

@interface HomeBannerCell : UITableViewCell

- (void)setImageUrl:(NSString *)url;

+ (CGFloat)getCellHeight;

@end
