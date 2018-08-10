//
//  PPFreeTransition.h
//  TransitionDemo
//
//  Created by 裴文芹 on 2018/2/1.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  动画过渡代理管理的是push还是pop
 */
typedef NS_ENUM(NSUInteger, ADCardTransitionType) {
    ADCardTransitionTypePush = 0,
    ADCardTransitionTypePop
};

@interface PPFreeTransition : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  初始化动画过渡代理
 */
+ (instancetype)transitionWithType:(ADCardTransitionType)type;
- (instancetype)initWithTransitionType:(ADCardTransitionType)type;

@end
