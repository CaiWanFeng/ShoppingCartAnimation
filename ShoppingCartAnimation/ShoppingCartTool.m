//
//  ShoppingCartTool.m
//  ShoppingCartAnimation
//
//  Created by 蔡强 on 2017/7/17.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "ShoppingCartTool.h"

@implementation ShoppingCartTool

/**
 加入购物车的动画效果
 
 @param goodsImage 商品图片
 @param startPoint 动画起点
 @param endPoint   动画终点
 @param completion 动画执行完成后的回调
 */
+ (void)addToShoppingCartWithGoodsImage:(UIImage *)goodsImage startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint completion:(void (^)(BOOL))completion{
    //------- 创建shapeLayer -------//
    CAShapeLayer *animationLayer = [[CAShapeLayer alloc] init];
    animationLayer.frame = CGRectMake(startPoint.x - 20, startPoint.y - 20, 40, 40);
    animationLayer.contents = (id)goodsImage.CGImage;
    
    // 获取window的最顶层视图控制器
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    UIViewController *parentVC = rootVC;
    while ((parentVC = rootVC.presentedViewController) != nil ) {
        rootVC = parentVC;
    }
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    // 添加layer到顶层视图控制器上
    [rootVC.view.layer addSublayer:animationLayer];
    
    
    //------- 创建移动轨迹 -------//
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:startPoint];
    
    // 确定抛物线的最高点位置  controlPoint
    [movePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(200,100)];
    //关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGFloat durationTime = 1; // 动画时间1秒
    pathAnimation.duration = durationTime;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    
    pathAnimation.path = movePath.CGPath;
    
    
    //------- 创建动画 -------//
    [animationLayer addAnimation:pathAnimation forKey:nil];
    
    //------- 动画结束后 -------//
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(durationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 动画结束后异步执行这里的代码...
        [animationLayer removeFromSuperlayer];
        // 执行动画完成的block
        completion(YES);
    });
}

@end
