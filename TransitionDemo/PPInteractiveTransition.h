//
//  PPInteractiveTransition.h
//  TransitionDemo
//
//  Created by wq pei on 2018/4/20.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^gestureConfig)(void);

typedef NS_ENUM(NSUInteger, PPInteractiveTransitionGestureDirection) {
    //手势的方向
    PPInteractiveTransitionGestureDirectionLeft,
    PPInteractiveTransitionGestureDirectionRight,
    PPInteractiveTransitionGestureDirectionUp,
    PPInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, PPInteractiveTransitionGestureScene) {
    //转场驱动场景
    PPInteractiveTransitionGestureScenePush,
    PPInteractiveTransitionGestureScenePop,
    PPInteractiveTransitionGestureScenePresent,
    PPInteractiveTransitionGestureSceneDismiss
};


@interface PPInteractiveTransition : UIPercentDrivenInteractiveTransition

//记录是否开始手势，判断转场的操作是手势出发还是点击返回键出发
@property (nonatomic, assign) BOOL gestureInteraction;
//navigation触发，调用的config
@property (nonatomic, copy) gestureConfig navigationConfig;
//modal触发，调用config
@property (nonatomic, copy) gestureConfig modalConfig;

//初始化方法 + //给传入的控制器添加手势
+ (instancetype)interactiveTransitionWithDirection:(PPInteractiveTransitionGestureDirection)direction sceneType:(PPInteractiveTransitionGestureScene)sceneType viewController:(UIViewController *)viewController;
- (instancetype)initWithInteractiveTransitionDirection:(PPInteractiveTransitionGestureDirection)direction sceneType:(PPInteractiveTransitionGestureScene)sceneType viewController:(UIViewController *)viewController;




@end
