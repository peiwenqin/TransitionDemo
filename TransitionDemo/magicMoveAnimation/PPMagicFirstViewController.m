//
//  PPMagicFirstViewController.m
//  TransitionDemo
//
//  Created by wq pei on 2018/4/23.
//  Copyright © 2018年 helloWorld. All rights reserved.
//

#import "PPMagicFirstViewController.h"
#import "PPMagicImageCell.h"
#import "PPMagicSecondViewController.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface PPMagicFirstViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)  UICollectionViewFlowLayout *layout;

@end

@implementation PPMagicFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.itemSize = CGSizeMake(screenWidth - 30*2 - 40, screenHeight - 250);
    self.layout.minimumLineSpacing = 30;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:_layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"PPMagicImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PPMagicImageCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PPMagicImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PPMagicImageCell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.currentIndexPath = indexPath;
    //开始设计动画模式
    PPMagicSecondViewController *vc = [[PPMagicSecondViewController alloc] init];
    self.navigationController.delegate = vc;
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
