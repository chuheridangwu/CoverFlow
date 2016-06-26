//
//  WaterFallViewLayout.h
//  UIControllerView
//
//  Created by DYM on 16/6/25.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallViewLayout;
@protocol WaterFallViewLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(WaterFallViewLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth;
@optional
- (CGFloat)columnCountInWaterflowLayout:(WaterFallViewLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WaterFallViewLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterFallViewLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFallViewLayout *)waterflowLayout;
@end

@interface WaterFallViewLayout : UICollectionViewLayout
@property (nonatomic,weak)id<WaterFallViewLayoutDelegate> delegate;
@end
