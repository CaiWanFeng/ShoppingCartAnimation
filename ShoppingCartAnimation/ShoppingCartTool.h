//
//  ShoppingCartTool.h
//  ShoppingCartAnimation
//
//  Created by 蔡强 on 2017/7/17.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShoppingCartTool : NSObject

/**
 加入购物车的动画效果
 
 @param goodsImage 商品图片
 @param startPoint 动画起点
 @param endPoint   动画终点
 @param completion 动画执行完成后的回调
 */
+ (void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage
                             startPoint:(CGPoint)startPoint
                               endPoint:(CGPoint)endPoint
                             completion:(void (^)(BOOL finished))completion;

@end
