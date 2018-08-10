//
//  PPFreeTransition.m
//  TransitionDemo
//
//  Created by 裴文芹 on 2018/2/1.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "PPFreeTransition.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PPFreeTransition()
/**
 *  动画过渡代理管理的是push还是pop
 */
@property (nonatomic, assign) ADCardTransitionType type;

@end

@implementation PPFreeTransition

//static ScreenWidth = [UIScreen mainScreen].bounds.size.width;
//static ScreenHeight = [UIScreen mainScreen].bounds.size.height;

+ (instancetype)transitionWithType:(ADCardTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(ADCardTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (_type == ADCardTransitionTypePush) {
        [self pushAnimation:transitionContext];
    } else {
        [self popAnimation:transitionContext];
    }
}

//执行push过渡动画
- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //实现界面截屏---不能用当前vc截屏，否则会导致截屏的导航无效
    UIView *tempView = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:NO];
    tempView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    tempView.layer.cornerRadius = 10;
    tempView.layer.masksToBounds = YES;
//    fromView.hidden = YES;
    [containerView addSubview:tempView];
    [containerView addSubview:toView];
    
    toView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight - 250);

    //仿iPhone邮箱编辑动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toView.frame = CGRectMake(0, 250, ScreenWidth, ScreenHeight - 250);
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        fromView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        
    } completion:^(BOOL finished) {

        fromView.transform = CGAffineTransformMakeScale(1, 1);
        [transitionContext completeTransition:finished];//该句话必要，否则第二个界面不响应点击事件
        toView.frame = CGRectMake(0, 250, ScreenWidth, ScreenHeight - 250);

    }];
}

//执行pop过渡动画
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];//UITransitionContextFromViewKey
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];//UITransitionContextToViewKey
    
    NSArray *subviewsArray = containerView.subviews;
    UIView *tempView = subviewsArray[MIN(subviewsArray.count, MAX(0, subviewsArray.count - 2))];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        fromVC.view.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
        tempView.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        
        [containerView addSubview:toVC.view];

        [transitionContext completeTransition:finished];
        [tempView removeFromSuperview];
    }];
}

@end
