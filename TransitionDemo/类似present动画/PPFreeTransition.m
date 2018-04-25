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
    UIViewController *fromVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];//UITransitionContextFromViewKey
    UIViewController *toVC = (UIViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];//UITransitionContextToViewKey
    
    //实现界面截屏

    
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    fromVC.view.hidden = YES;
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    toVC.view.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);

    //仿iPhone邮箱编辑动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -(ScreenHeight - 200));
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        [containerView layoutIfNeeded];
        
    } completion:^(BOOL finished) {

        [transitionContext completeTransition:finished];//该句话必要，否则第二个界面不响应点击事件--为什么？可是写了，fromVC消失了。。。解决
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
        
        tempView.transform = CGAffineTransformIdentity;
        fromVC.view.transform = CGAffineTransformIdentity;

    } completion:^(BOOL finished) {
        
        toVC.view.hidden = NO;
        [containerView addSubview:toVC.view];

        [transitionContext completeTransition:YES];
        [tempView removeFromSuperview];
    }];
}

@end
