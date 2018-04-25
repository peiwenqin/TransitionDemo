//
//  FirstViewController.m
//  TransitionDemo
//
//  Created by 裴文芹 on 2018/2/1.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "PPInteractiveTransition.h"

@interface FirstViewController ()

@property (nonatomic, strong) PPInteractiveTransition *transition;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
//    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
//    [btn setTitle:@"返回" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
//    _transition = [[PPInteractiveTransition alloc] initWithInteractiveTransitionDirection:PPInteractiveTransitionGestureDirectionUp sceneType:PPInteractiveTransitionGestureScenePush viewController:self.navigationController];
//    typeof(self) weakSelf = self;
//    [_transition setNavigationConfig:^{
//        [weakSelf nextPageAction:nil];
//    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}



- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextPageAction:(id)sender {
    SecondViewController *vc = [[SecondViewController alloc] init];
    self.navigationController.delegate = vc;//***1***必须在push之前复制代理，否则不能找到自定义的push方法
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
