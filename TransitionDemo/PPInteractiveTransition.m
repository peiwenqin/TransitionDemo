//
//  PPInteractiveTransition.m
//  TransitionDemo
//
//  Created by wq pei on 2018/4/20.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "PPInteractiveTransition.h"

@implementation PPInteractiveTransition
{
    PPInteractiveTransitionGestureDirection _direction;//手势方向
    PPInteractiveTransitionGestureScene _sceneType;//手势场景
    UIViewController *vc;
}

//初始化方法
+ (instancetype)interactiveTransitionWithDirection:(PPInteractiveTransitionGestureDirection)direction sceneType:(PPInteractiveTransitionGestureScene)sceneType viewController:(UIViewController *)viewController
{
    return [[self alloc] initWithInteractiveTransitionDirection:direction sceneType:sceneType viewController:(UIViewController *)viewController];
}

- (instancetype)initWithInteractiveTransitionDirection:(PPInteractiveTransitionGestureDirection)direction sceneType:(PPInteractiveTransitionGestureScene)sceneType viewController:(UIViewController *)viewController
{
    self = [super init];
    if (self) {
        _direction = direction;
        _sceneType = sceneType;
        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        vc = viewController;
        [vc.view addGestureRecognizer:gesture];
    }
    return self;
}

//处理手势过渡
- (void)handleGesture:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"-----%@",gesture);
    CGFloat process = 0;
    switch (_direction) {
        case PPInteractiveTransitionGestureDirectionUp:
        {
            CGFloat transitionY = -[gesture translationInView:gesture.view].y;
            process = transitionY / gesture.view.frame.size.width;
        }
            break;
        case PPInteractiveTransitionGestureDirectionDown:
        {
            CGFloat transitionY = [gesture translationInView:gesture.view].y;
            process = transitionY / gesture.view.frame.size.width;
        }
            break;
        case PPInteractiveTransitionGestureDirectionLeft:
        {
            CGFloat transitionX = -[gesture translationInView:gesture.view].x;
            process = transitionX / gesture.view.frame.size.width;
        }
            break;
        case PPInteractiveTransitionGestureDirectionRight:
        {
            CGFloat transitionX = [gesture translationInView:gesture.view].x;
            process = transitionX / gesture.view.frame.size.width;
        }
            break;
        default:
            break;
    }
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.gestureInteraction = YES;
            [self startGesture];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            [self updateInteractiveTransition:process];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.gestureInteraction = NO;
            if (process > 0.5) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
        }
            break;
        default:
            break;
    }
}

- (void)startGesture
{
    switch (_sceneType) {
        case PPInteractiveTransitionGestureScenePush:
        {
            if (_navigationConfig) {
                _navigationConfig();
            }
        }
            break;
        case PPInteractiveTransitionGestureScenePop:
        {
            [vc.navigationController popViewControllerAnimated:YES];
        }
            break;
        case PPInteractiveTransitionGestureScenePresent:
        {
            if (_modalConfig) {
                _modalConfig();
            }
        }
            break;
        case PPInteractiveTransitionGestureSceneDismiss:
        {
            [vc.navigationController popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
}

@end
