//
//  HorizontalViewController.m
//  UIControllerView
//
//  Created by 龙少 on 16/6/25.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import "HorizontalViewController.h"
#import "CollectionViewFlowLayout.h"

#define CollectionCellIdentifier  @"CollectionCellIdentifier"

@interface HorizontalViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>


@end

@implementation HorizontalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置布局方式
    CollectionViewFlowLayout *layout = [[CollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width,180 ) collectionViewLayout:layout];
    collection.delegate = self;
    collection.dataSource = self;
    //设置Cell类型
    [collection registerClass:[UICollectionViewCell  class] forCellWithReuseIdentifier:CollectionCellIdentifier];
    
    [self.view addSubview:collection ];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 注意点：1.UICollectionView如果现实item需要注册一个布局方式，UICollectionViewFlowLayout，并且给出cell类型和标示
 2.如果想要水平滚动，需要在设置给UICollectionView布局的时候进行说明-layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
 3.如果想自定义布局，需要自定义UICollectionViewFlowLayout，重写里面的方法- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
 4.如果想确定滚动后的位置，或者在滚动期间做些其他事情，重写- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
 
 
 */

@end
