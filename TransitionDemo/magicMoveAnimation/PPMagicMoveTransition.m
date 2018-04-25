//
//  PPMagicMoveTransition.m
//  TransitionDemo
//
//  Created by wq pei on 2018/4/23.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "PPMagicMoveTransition.h"
#import "PPMagicImageCell.h"
#import "PPMagicFirstViewController.h"
#import "PPMagicSecondViewController.h"

@interface PPMagicMoveTransition()

@property (nonatomic, assign) PPMagicMoveTransitionType sceneType;

@end

@implementation PPMagicMoveTransition

//初始化动画类型
+ (instancetype)magicMoveTransitionWithType:(PPMagicMoveTransitionType)type
{
    return [[self alloc] initMagicMoveTransitionWithType:type];
}

- (instancetype)initMagicMoveTransitionWithType:(PPMagicMoveTransitionType)type
{
    self = [super init];
    if (self) {
        _sceneType = type;
    }
    return self;
}

//进行动画，判断动画的进行
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return (self.animationTime && self.animationTime > 0) ? self.animationTime : 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (_sceneType == PPMagicMoveTransitionTypePush) {
        //执行push动画
        [self animatiedPushWithTransition:transitionContext];
    } else {
        //执行pop动画
        [self animatiedPopWithTransition:transitionContext];
    }
}

//push动画
- (void)animatiedPushWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    PPMagicFirstViewController *fromVC = (PPMagicFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PPMagicSecondViewController *toVC = (PPMagicSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    PPMagicImageCell *cell = (PPMagicImageCell *)[fromVC.collectionView cellForItemAtIndexPath:fromVC.currentIndexPath];
    UIView *tempImageView = [cell.showImageView snapshotViewAfterScreenUpdates:NO];//YES  <==>  NO
    tempImageView.frame = [cell.showImageView convertRect:cell.showImageView.bounds toView:containerView];
    cell.showImageView.hidden = YES;
    toVC.showImgV.hidden = YES;
    [containerView addSubview:toVC.view];
//    toVC.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [containerView addSubview:tempImageView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        
        tempImageView.frame = [toVC.showImgV convertRect:toVC.showImgV.bounds toView:containerView];
        
    } completion:^(BOOL finished) {
        cell.showImageView.hidden = NO;
        tempImageView.hidden = YES;
        [tempImageView removeFromSuperview];
        toVC.showImgV.hidden = NO;
        [transitionContext completeTransition:finished];
    }];
}

//pop动画
- (void)animatiedPopWithTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    PPMagicSecondViewController *fromVC = (PPMagicSecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    PPMagicFirstViewController *toVC = (PPMagicFirstViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *tempView = [fromVC.showImgV snapshotViewAfterScreenUpdates:NO];
    tempView.frame = [fromVC.showImgV convertRect:fromVC.showImgV.bounds toView:containerView];
    fromVC.showImgV.hidden = YES;
    [containerView addSubview:toVC.view];
    [containerView addSubview:tempView];
    PPMagicImageCell *cell = (PPMagicImageCell *)[toVC.collectionView cellForItemAtIndexPath:toVC.currentIndexPath];
    cell.showImageView.hidden = YES;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        tempView.frame = [cell.showImageView convertRect:cell.showImageView.bounds toView:containerView];

    } completion:^(BOOL finished) {

        cell.showImageView.hidden = NO;
        [tempView removeFromSuperview];
        [transitionContext completeTransition:YES];
        
    }];
}
   

@end
