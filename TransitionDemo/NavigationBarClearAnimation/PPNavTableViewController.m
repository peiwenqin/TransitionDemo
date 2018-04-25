//
//  PPNavTableViewController.m
//  TransitionDemo
//
//  Created by 裴文芹 on 2018/2/6.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "PPNavTableViewController.h"

@interface PPNavTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIImageView *navBgView;

@end

@implementation PPNavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去除 navigationBar 底部的细线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    _navBgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height + 20)];
    [self.navigationController.view insertSubview:_navBgView belowSubview:self.navigationController.navigationBar];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerBg"]];
    imgView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    self.tableView.tableHeaderView = imgView;
    
}

#pragma mark----------------------
#pragma mark setupUI
- (void)loadNeedLayoutView
{
    
}

#pragma mark----------------------
#pragma mark UItableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat alpha = scrollView.contentOffset.y/300;
    if (alpha > 1) {
        alpha = 1;
    }
    self.navBgView.backgroundColor = [UIColor colorWithRed:242.0/255 green:100.0/255 blue:50.0/255 alpha:alpha];
}


#pragma mark----------------------
#pragma mark CustomAction


#pragma mark----------------------
#pragma mark netWork


#pragma mark----------------------
#pragma mark setter && getter




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
