//
//  SecondViewController.m
//  TransitionDemo
//
//  Created by 裴文芹 on 2018/2/1.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "SecondViewController.h"
#import "PPFreeTransition.h"
#import "PPInteractiveTransition.h"

@interface SecondViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) PPInteractiveTransition *transition;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBar.hidden = YES;

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [self.view addGestureRecognizer:gesture];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [button setTitle:@"back" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 100, 100)];
    [nextBtn setTitle:@"next" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    NSLog(@"11-----%@",self.view);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"22-----%@",self.view);
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [PPFreeTransition transitionWithType:operation == UINavigationControllerOperationPush ? ADCardTransitionTypePush : ADCardTransitionTypePop];
}


- (void)backAction
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)nextAction
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
