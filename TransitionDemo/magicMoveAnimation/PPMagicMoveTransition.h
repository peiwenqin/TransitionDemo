//
//  PPMagicMoveTransition.h
//  TransitionDemo
//
//  Created by wq pei on 2018/4/23.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PPMagicMoveTransitionType) {
    //说明转场类型
    PPMagicMoveTransitionTypePush = 0,
    PPMagicMoveTransitionTypePop
};

@interface PPMagicMoveTransition : NSObject<UIViewControllerAnimatedTransitioning>



@property (nonatomic, assign) CGFloat animationTime;//若未赋值，则默认0.3秒


//初始化动画类型
+ (instancetype)magicMoveTransitionWithType:(PPMagicMoveTransitionType)type;
- (instancetype)initMagicMoveTransitionWithType:(PPMagicMoveTransitionType)type;

@end
