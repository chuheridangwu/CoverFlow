//
//  WaterFallViewController.m
//  UIControllerView
//
//  Created by DYM on 16/6/25.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import "WaterFallViewController.h"
#import "WaterFallViewLayout.h"
#import "XBShopModel.h"
#import "WaterCollectionViewCell.h"
#import "MJRefresh.h"
#import "MJExtension.h"

#define CollectionCellIdentifier  @"CollectionCellIdentifier"

@interface WaterFallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterFallViewLayoutDelegate>
@property (nonatomic,strong)UICollectionView *collection;
@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation WaterFallViewController


- (NSMutableArray*)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupLayout];
    
    // 上拉刷新
    [self setupRefresh];
}

- (void)setupLayout{
    //设置布局方式
    WaterFallViewLayout *layout = [[WaterFallViewLayout alloc]init];
    layout.delegate = self;
    
    self.collection = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    //设置Cell类型
    [self.collection registerClass:[WaterCollectionViewCell  class] forCellWithReuseIdentifier:CollectionCellIdentifier];
    self.collection.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collection ];
}

- (void)setupRefresh{
    self.collection.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    [self.collection.header beginRefreshing];
    
    self.collection.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
    self.collection.footer.hidden = YES;
}

- (void)loadNewShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [XBShopModel objectArrayWithFilename:@"1.plist"];
        [self.array removeAllObjects];
        [self.array addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collection reloadData];
        
        [self.collection.header endRefreshing];
    });
}

- (void)loadMoreShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [XBShopModel objectArrayWithFilename:@"1.plist"];
        [self.array addObjectsFromArray:shops];
        
        // 刷新数据
        [self.collection reloadData];
        
        [self.collection.footer endRefreshing];
    });
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:CollectionCellIdentifier forIndexPath:indexPath];
    
    cell.model = self.array[indexPath.item];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#warning --------  WaterFallViewLayoutDelegate
-(CGFloat)waterflowLayout:(WaterFallViewLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    XBShopModel *shop = self.array[index];
    return itemWidth * shop.h / shop.w;
}

/*
  注意点：虽然有时候使用属性传值可以满足我们的要求，如果是做通用框架，最好使用代理进行传值计算，这样的好处是可以由我们进行控制什么时候刷新数据。
 
 
*/

@end
