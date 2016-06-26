//
//  WaterCollectionViewCell.m
//  UIControllerView
//
//  Created by DYM on 16/6/26.
//  Copyright © 2016年 龙少. All rights reserved.
//

#import "WaterCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "XBShopModel.h"

@interface WaterCollectionViewCell ()
{
    UIImageView *_shopImg;
    UILabel *_priceLabel;
    UIView *_bottonView;
}
@end

@implementation WaterCollectionViewCell
- (void)setModel:(XBShopModel *)model{
    _model = model;
    self.backgroundColor = [UIColor redColor];
//  [self setSubView:model];
}

- (void)setSubView:(XBShopModel*)model{
    [_bottonView removeFromSuperview];
    _bottonView = [[UIView alloc]initWithFrame:self.contentView.frame];
    [self.contentView addSubview:_bottonView];
    
    _shopImg = [[UIImageView alloc]initWithFrame:self.contentView.frame];
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"place.png"]];
    [_bottonView addSubview:_shopImg];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.contentView.bounds.size.height - 40, self.frame.size.width, 40)];
    _priceLabel.text = model.price;
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [_bottonView addSubview:_priceLabel];
    
}

@end
