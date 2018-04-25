//
//  PPMagicSecondViewController.m
//  TransitionDemo
//
//  Created by wq pei on 2018/4/23.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "PPMagicSecondViewController.h"
#import "PPMagicMoveTransition.h"

@interface PPMagicSecondViewController ()

@end

@implementation PPMagicSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.showImgV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 80, 80)];
    self.showImgV.image = [UIImage imageNamed:@"happy"];
    [self.view addSubview:self.showImgV];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 120, 30)];
    self.titleLab.text = @"title";
    [self.view addSubview:self.titleLab];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [PPMagicMoveTransition magicMoveTransitionWithType:operation == UINavigationControllerOperationPush ? PPMagicMoveTransitionTypePush : PPMagicMoveTransitionTypePop];
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
