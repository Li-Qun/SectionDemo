//
//  HFAutomaticShowAlertView.m
//  dailylife
//
//  Created by HF on 15/6/10.
//
//

#import "HFNoteView.h"
#import "MBProgressHUD.h"

@implementation HFNoteView
{
    MBProgressHUD *HUD ;
}

- (id) initShowContent:(NSString *)content
{
    self = [super init];
    if(self){
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        HUD = [[MBProgressHUD alloc] initWithWindow:window];
        [window addSubview:HUD];
        //指定距离中心点的X轴和Y轴的位置，不指定则在屏幕中间显示
        //    HUD.yOffset = 100.0f;
        //    HUD.xOffset = 100.0f;
        HUD.mode = MBProgressHUDModeText;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        HUD.removeFromSuperViewOnHide = YES;
        HUD.userInteractionEnabled = NO;
        //HUD.labelText = content; 只适合短文本 1行
        HUD.detailsLabelText = content; // 详细显示文本 多行
    }
    return self;
}

+ (void)showMessage:(NSString *)msg
{
     [[[HFNoteView alloc]initShowContent:msg] show];
}

+ (void)showLoading
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD showHUDAddedTo:window animated:YES];
}

+ (void)dismissLoading
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD hideHUDForView:window animated:YES];
}

- (void) show
{
    [self showDuration:1 complete:nil];
}

- (void) showComplete:(void(^)(void))completionBlock
{
    [self showDuration:1 complete:completionBlock];
}


- (void) showDuration:(int)second complete:(void(^)(void))completionBlock
{
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(second);
    } completionBlock:^{
        [HUD setHidden:YES];
        if(completionBlock)
            completionBlock();
    }];
}


@end
