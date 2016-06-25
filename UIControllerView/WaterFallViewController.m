//
//  WaterFallViewController.m
//  UIControllerView
//
//  Created by DYM on 16/6/25.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFallViewLayout.h"

#define CollectionCellIdentifier  @"CollectionCellIdentifier"

@interface WaterFallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置布局方式
    WaterFallViewLayout *layout = [[WaterFallViewLayout alloc]init];
    
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
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

 1.因为算布局只需要在初始化的时候算一次就好，所以将算布局的代码放在
 
*/

@end
