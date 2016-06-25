//
//  CollectionViewFlowLayout.m
//  UIControllerView
//
//  Created by 龙少 on 16/6/25.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import "CollectionViewFlowLayout.h"

@implementation CollectionViewFlowLayout
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //1.获取cell对应的attributes对象
    NSArray *arrayAtts = [super layoutAttributesForElementsInRect:rect];
    
    //2.计算整体的中心点的X值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    //3.修改attributes对象
    for (UICollectionViewLayoutAttributes *Atter in arrayAtts) {
        //计算cell到中心点的距离
        CGFloat distance = ABS(Atter.center.x - centerX);
        //距离越大，缩放比越小，距离越小，缩放比越大
        CGFloat factor = 0.003;
        CGFloat scal = 1 / (1 + distance * factor);
        
        Atter.transform = CGAffineTransformMakeScale(scal, scal);
    }
    
    return arrayAtts;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//每次滚动之后让只有一个cell显示在中间,重写该方法，在里面计算返回滚动后的位置；
//proposedContentOffset 滑动快速的时候停留的位置
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    //1.计算UICollectionView距离中间屏幕的X值
    CGFloat centerX = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    
     //2.获取屏幕内cell的Attribute对象
    CGFloat visibleX = proposedContentOffset.x;
    CGFloat visibleY = proposedContentOffset.y;
     CGFloat visibleW = self.collectionView.bounds.size.width;
    CGFloat visibleH = self.collectionView.bounds.size.height;
    NSArray *arrayAttrs = [self layoutAttributesForElementsInRect:CGRectMake(visibleX, visibleY, visibleW, visibleH)];
    
    // 拿到Attribute对象，找出距离中心点centerX最近的一个cell
    int min_idx = 0;
    UICollectionViewLayoutAttributes *min_atter = arrayAttrs[min_idx];
    for (int i = 0; i < arrayAttrs.count; i++) {
        //计算里面的距离
        CGFloat distancel = ABS(min_atter.center.x - centerX);
        
        //
        UICollectionViewLayoutAttributes *OBJ = arrayAttrs[i];
        CGFloat distance2 = ABS(OBJ.center.x - centerX);
        
        if (distance2 < distancel) {
            min_idx = i;
            min_atter = OBJ;
        }
    }

    CGFloat offsetX = min_atter.center.x - centerX;
    return CGPointMake(proposedContentOffset.x + offsetX, proposedContentOffset
                       .y);
}
@end
