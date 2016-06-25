//
//  WaterFallViewLayout.m
//  UIControllerView
//
//  Created by DYM on 16/6/25.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import "WaterFallViewLayout.h"

/** 默认的列数 */
static const NSInteger XBDefaultColumnCount = 3;
/** 每一列之间的间距 */
static const CGFloat XBDefaultColumnMargin = 10;
/** 每一行之间的间距 */
static const CGFloat XBDefaultRowMargin = 10;
/** 边缘间距，使用结构体的写法，相当于 UIEdgeInsetsMake(10, 10, 10, 10); */
static const UIEdgeInsets XBDefaultEdgeInsets = {10, 10, 10, 10};

@interface WaterFallViewLayout ()
/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
@end

@implementation WaterFallViewLayout

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

// 初始化
- (void)prepareLayout{
    [super prepareLayout];
    
    // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < XBDefaultColumnCount; i++) {
        [self.columnHeights addObject:@(XBDefaultEdgeInsets.top)];
    }
    
    //清楚以前的布局属性
    [self.attrsArray removeAllObjects];
     NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
       //获取indexPatch对应的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attrsArray  addObject:attrs];
    }
    
 
}

/**
 * 决定cell的排布
 */

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

// 返回indexPath位置对应的cell属性，算坐标应该在这里算
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //设置布局属性的frame
    CGFloat collectioViewW = self.collectionView.bounds.size.width;
    CGFloat W = (collectioViewW - XBDefaultEdgeInsets.left - XBDefaultEdgeInsets.right - (XBDefaultColumnCount - 1) * XBDefaultColumnMargin) / XBDefaultColumnCount;
    CGFloat h = 50 + arc4random_uniform(100);;
    
    //瀑布流就是将cell放在上一行最短的那一列，只要找到是最短的，在第几行，就可以确定XY
    //找出高度最短的那一列
     NSInteger destColum = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];;
    for (NSInteger i = 1; i < XBDefaultColumnCount; i++) {
        //取得第一列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColum = i;
        }
    }
  
    
    CGFloat x = XBDefaultEdgeInsets.left + destColum * (W + XBDefaultColumnMargin);
    CGFloat y = minColumnHeight;
    if (y != XBDefaultEdgeInsets.top) {
        y += XBDefaultRowMargin;
    }
    attrs.frame = CGRectMake(x, y, W, h);
    
    // 更新最短那列的高度
    self.columnHeights[destColum] = @(CGRectGetMaxY(attrs.frame));
    return attrs;
}

- (CGSize)collectionViewContentSize{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < XBDefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + XBDefaultEdgeInsets.bottom);
}

/*
 
 1.因为算布局只需要在初始化的时候算一次就好，所以将算布局的代码放在- (void)prepareLayout
 
 */

/*
 //找出高度最短的那一列
 __block NSInteger destColum = 0;
 __block CGFloat minColumnHeight = MAXFLOAT;
 [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
 CGFloat colmnHeight = columnHeightNumber.doubleValue;
 if (minColumnHeight > colmnHeight) {
 minColumnHeight = colmnHeight;
 destColum = idx;
 }
 }];
 */

@end
