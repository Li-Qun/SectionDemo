//
//  HFRefreshHeader.m
//  SectionDemo
//
//  Created by HF on 17/3/30.
//  Copyright © 2017年 HF-Liqun. All rights reserved.
//

#import "HFRefreshHeader.h"

@interface HFRefreshHeader  ()

@property (weak, nonatomic) UIImageView *arrowView;
/** 菊花 */
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

/** 所有状态对应的文字 */
@property (strong, nonatomic) NSMutableDictionary *stateTitles;
@property (weak, nonatomic, readwrite) UILabel *stateLabel;

@property (assign, nonatomic) CGFloat insetTDelta;
@property (nonatomic) CGFloat refreshHeight;    // 正在刷新时，控件的高度

@end

@implementation HFRefreshHeader

#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    HFRefreshHeader *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    HFRefreshHeader *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 懒加载
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:@"下拉刷新"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (NSMutableDictionary *)stateTitles
{
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

- (UILabel *)stateLabel
{
    if (!_stateLabel) {
        [self addSubview:_stateLabel = [UILabel mj_label]];
        _stateLabel.textColor = [UIColor grayColor];
    }
    return _stateLabel;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(MJRefreshState)state
{
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    self.stateLabel.text = self.stateTitles[@(self.state)];
}

#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    self.backgroundColor = [UIColor lightGrayColor];
    // 设置高度
    self.mj_h = 1000;
    self.refreshHeight = MJRefreshFooterHeight;
    
    // 初始化间距
    self.labelLeftInset = MJRefreshLabelLeftInset;
    
    // 初始化文字
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshHeaderIdleText] forState:MJRefreshStateIdle];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshHeaderPullingText] forState:MJRefreshStatePulling];
    [self setTitle:[NSBundle mj_localizedStringForKey:MJRefreshHeaderRefreshingText] forState:MJRefreshStateRefreshing];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 设置y值
    self.mj_y = - self.mj_h;
    
    
    if (self.stateLabel.hidden) return;
    
    // 状态
    self.stateLabel.mj_x = 0.f;
    self.stateLabel.mj_w = self.mj_w;
    self.stateLabel.mj_h = self.refreshHeight;
    self.stateLabel.mj_y = self.mj_h - self.refreshHeight;
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat stateWidth = self.stateLabel.mj_textWith;
        CGFloat timeWidth = 0.0;
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + self.labelLeftInset;
    }
    CGFloat arrowCenterY = self.refreshHeight * 0.5 + (self.stateLabel.mj_y);
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
    
    self.arrowView.tintColor = self.stateLabel.textColor;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 在刷新的refreshing状态
    if (self.state == MJRefreshStateRefreshing) {
        if (self.window == nil) return;
        
        // sectionheader停留解决
        CGFloat insetT = - self.scrollView.mj_offsetY > _scrollViewOriginalInset.top ? - self.scrollView.mj_offsetY : _scrollViewOriginalInset.top;
        insetT = insetT > self.refreshHeight + _scrollViewOriginalInset.top ? self.refreshHeight + _scrollViewOriginalInset.top : insetT;
        self.scrollView.mj_insetT = insetT;
        
        self.insetTDelta = _scrollViewOriginalInset.top - insetT;
        return;
    }
    
    // 跳转到下一个控制器时，contentInset可能会变
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat normal2pullingOffsetY = happenOffsetY - self.refreshHeight;
    CGFloat pullingPercent = (happenOffsetY - offsetY) / self.refreshHeight;
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        self.pullingPercent = pullingPercent;
        if (self.state == MJRefreshStateIdle && offsetY < normal2pullingOffsetY) {
            // 转为即将刷新状态
            self.state = MJRefreshStatePulling;
        } else if (self.state == MJRefreshStatePulling && offsetY >= normal2pullingOffsetY) {
            // 转为普通状态
            self.state = MJRefreshStateIdle;
        }
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            
            // 保存刷新时间
            //        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
            //        [[NSUserDefaults standardUserDefaults] synchronize];
            
            // 恢复inset和offset
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.scrollView.mj_insetT += self.insetTDelta;
                
                // 自动调整透明度
                if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.pullingPercent = 0.0;
                
                if (self.endRefreshingCompletionBlock) {
                    self.endRefreshingCompletionBlock();
                }
            }];
        }
    } else if (state == MJRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                CGFloat top = self.scrollViewOriginalInset.top + self.refreshHeight;
                // 增加滚动区域top
                self.scrollView.mj_insetT = top;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
    
    // 设置状态文字
    self.stateLabel.text = self.stateTitles[@(state)];
    
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = YES;
    }
}

#pragma mark - 公共方法
- (void)endRefreshing
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.state = MJRefreshStateIdle;
    });
}

@end

@implementation HFRefreshGifHeader


#pragma mark - 构造方法
+ (instancetype)headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
{
    HFRefreshGifHeader *cmp = [self getGifHeader];
    cmp.refreshingBlock = refreshingBlock;
    
    if (!cmp) {
        cmp =  (HFRefreshGifHeader *)[HFRefreshHeader headerWithRefreshingBlock:refreshingBlock];
    }
    return cmp;
}
+ (instancetype)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    HFRefreshGifHeader *cmp = [self getGifHeader];
    
    if (!cmp) {
        cmp =  (HFRefreshGifHeader *)[HFRefreshHeader headerWithRefreshingTarget:target refreshingAction:action];
    } else {
        [cmp setRefreshingTarget:target refreshingAction:action];
    }
    return cmp;
}

+ (HFRefreshGifHeader *)getGifHeader
{
    HFRefreshGifHeader *cmp = [[self alloc] init];
    
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    NSMutableArray *pullingImages = [NSMutableArray array];
    int count = 29;
    float eachSec = 0.04;
    for (int i = 0; i < count; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%02d.png",i]];
        if (image) {
            [refreshingImages addObject:image];
        }
    }
    if (refreshingImages.count > 0) {
        [pullingImages addObject:refreshingImages.lastObject];
    } else {
        return nil;
    }
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [cmp setImages:pullingImages duration:eachSec forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [cmp setImages:refreshingImages duration:eachSec * count forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    cmp.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
    cmp.stateLabel.hidden = YES;
    
    return cmp;
}

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    if (self.scrollViewBlock) {
        NSValue *value = change[@"new"];
        CGPoint point = value.CGPointValue;
        //NSLog(@"contentOffset %f",  point.y  );
        self.scrollViewBlock(@(point.y));
    }
}

@end
