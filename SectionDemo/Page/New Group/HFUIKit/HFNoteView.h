//
//  HFAutomaticShowAlertView.h
//  dailylife
//
//  Created by HF on 15/6/10.
//
//

#import <UIKit/UIKit.h>


@interface HFNoteView : NSObject
/**
 *   初始化显示内容的ShowContent
 *
 *  @param content 文本内容
 *
 *  @return 初始化对象
 */
- (id) initShowContent:(NSString *)content;

/**
 展示提示语言 几秒后消失
 
 @param msg  提示语言
 */
+ (void)showMessage:(NSString *)msg;


/**
 展示loading
**/
+ (void)showLoading;


/**
 *  显示ShowContent
 */
- (void) show;
/**
 *  显示ShowContent
 *
 *  @param completionBlock  回调
 */
- (void) showComplete:(void(^)(void))completionBlock;
/**
 *  显示ShowContent
 *
 *  @param second          持续的时间
 *  @param completionBlock  回调
 */
- (void) showDuration:(int)second complete:(void(^)(void))completionBlock;


/**
 结束loading
 */
+ (void)dismissLoading;

@end
