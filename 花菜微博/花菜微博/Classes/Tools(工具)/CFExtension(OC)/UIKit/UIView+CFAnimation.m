//
//  UIView+XXAnimation.m
//
//  Created by 花菜ChrisCai on 2016/9/20.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIView+CFAnimation.h"
#import "UIView+CFFrame.h"
#import <objc/runtime.h>
#define BottomRect CGRectMake(self.frame.origin.x, [[UIScreen mainScreen] bounds].size.height, self.frame.size.width, self.frame.size.height)

@implementation UIView (XXAnimation)
#pragma mark - 底部出现动画
- (void)cf_showFromBottom {
    CGRect rect = self.frame;
    self.frame = BottomRect;
    [self executeAnimationWithFrame:rect completeBlock:nil];
}

#pragma mark - 底部消失动画
- (void)cf_dismissToBottomWithCompleteBlock:(void(^)())completeBlock {
    [self executeAnimationWithFrame:BottomRect completeBlock:completeBlock];
}

#pragma mark - 背景浮现动画
- (void)cf_emerge {
    self.alpha = 0.0;
    [self executeAnimationWithAlpha:0.2 completeBlock:nil];
}

#pragma mark - 背景淡去动画
- (void)cf_fake {
    [self executeAnimationWithAlpha:0.f completeBlock:nil];
}

#pragma mark - 执行动画
- (void)executeAnimationWithAlpha:(CGFloat)alpha completeBlock:(void(^)())completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = alpha;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

- (void)executeAnimationWithFrame:(CGRect)rect completeBlock:(void(^)())completeBlock{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        if (finished && completeBlock) completeBlock();
    }];
}

#pragma mark - 按钮震动动画
- (void)cf_startSelectedAnimation {
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    ani.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)],
                   [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    ani.removedOnCompletion = YES;
    ani.fillMode = kCAFillModeForwards;
    ani.duration = 0.4;
    [self.layer addAnimation:ani forKey:@"transformAni"];
}
#pragma mark - 点赞动画
- (void)cf_praiseEnlarge {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = @[
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]
                         ];
    animation.duration = 0.25;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"praiseEnlarge"];
}

#pragma mark - 粒子动画
- (void)cf_emitterAnimationWithImages:(NSArray <UIImage *> *)images inView:(UIView *)inView repeatTime:(NSTimeInterval)repeatTime  {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    CGRect rect = [self convertRect:self.frame toView:inView];
    // 发射器在xy平面的中心位置
    emitterLayer.emitterPosition = CGPointMake(self.cf_centerX,rect.origin.y);
    // 发射器的尺寸大小
    emitterLayer.emitterSize = CGSizeMake(20, 20);
    // 渲染模式
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
    // 开启三维效果
    //    _emitterLayer.preservesDepth = YES;
    NSMutableArray *array = [NSMutableArray array];
    // 创建粒子
    for (int i = 0; i<images.count; i++) {
        // 发射单元
        CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
        // 粒子的创建速率，默认为1/s
        stepCell.birthRate = 1;
        // 粒子存活时间
        stepCell.lifetime = arc4random_uniform(3) + 1;
        // 粒子的生存时间容差
        stepCell.lifetimeRange = 1.5;
        // 颜色
        // fire.color=[[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1]CGColor];
        //            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
        UIImage *image = images[i];
        // 粒子显示的内容
        stepCell.contents = (id)[image CGImage];
        // 粒子的名字
        //            [fire setName:@"step%d", i];
        // 粒子的运动速度
        stepCell.velocity = arc4random_uniform(100) + 100;
        // 粒子速度的容差
        stepCell.velocityRange = 80;
        // 粒子在xy平面的发射角度
        stepCell.emissionLongitude = M_PI+M_PI_2;;
        // 粒子发射角度的容差
        stepCell.emissionRange = M_PI_2/6;
        // 缩放比例
        stepCell.scale = 0.3;
        [array addObject:stepCell];
    }
    emitterLayer.emitterCells = array;
    [inView.layer insertSublayer:emitterLayer below:self.layer];
    
    // 延迟删除动画
    if (repeatTime != 0) {
        __weak typeof(emitterLayer) weakEmitterLayer = emitterLayer;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(repeatTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakEmitterLayer) emitterLayer = weakEmitterLayer;
            [emitterLayer removeFromSuperlayer];
            emitterLayer = nil;
        });
    }
    
}

- (void)cf_emitterAnimationWithImage:(UIImage *)image inView:(UIView *)inView repeatTime:(NSTimeInterval)repeatTime {
    CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
    CGRect rect = [self convertRect:self.frame toView:inView];
    // 发射器在xy平面的中心位置
    emitterLayer.emitterPosition = CGPointMake(self.cf_centerX,rect.origin.y);
    // 发射器的尺寸大小
    emitterLayer.emitterSize = CGSizeMake(20, 20);
    // 渲染模式
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
    // 开启三维效果
    //    _emitterLayer.preservesDepth = YES;
    NSMutableArray *array = [NSMutableArray array];
    // 创建粒子
        // 发射单元
        CAEmitterCell *stepCell = [CAEmitterCell emitterCell];
        // 粒子的创建速率，默认为1/s
        stepCell.birthRate = 1;
        // 粒子存活时间
        stepCell.lifetime = arc4random_uniform(3) + 1;
        // 粒子的生存时间容差
        stepCell.lifetimeRange = 1.5;
        // 粒子显示的内容
        stepCell.contents = (id)[image CGImage];
        // 粒子的名字
        //            [fire setName:@"step%d", i];
        // 粒子的运动速度
        stepCell.velocity = arc4random_uniform(100) + 100;
        // 粒子速度的容差
        stepCell.velocityRange = 80;
        // 粒子在xy平面的发射角度
        stepCell.emissionLongitude = M_PI+M_PI_2;;
        // 粒子发射角度的容差
        stepCell.emissionRange = M_PI_2/6;
        // 缩放比例
        stepCell.scale = 0.3;
        [array addObject:stepCell];
    
    emitterLayer.emitterCells = array;
    [inView.layer insertSublayer:emitterLayer below:self.layer];
    
    // 延迟删除动画
    if (repeatTime != 0) {
        __weak typeof(emitterLayer) weakEmitterLayer = emitterLayer;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(repeatTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakEmitterLayer) emitterLayer = weakEmitterLayer;
            [emitterLayer removeFromSuperlayer];
            emitterLayer = nil;
        });
    }
}

- (void)cf_animationInView:(UIView *)inView image:(UIImage *)image center:(CGPoint)center duration:(NSTimeInterval)duration {
    // 创建执行动画用的控件
    UIImageView * imageView = [[UIImageView alloc]initWithImage:image];
    imageView.center = center;
    // 添加到父控件
    [inView addSubview:imageView];
    
    // 创建临时变量
    CGFloat centerX = center.x;
    CGFloat centerY = center.y;
    CGFloat width = CGRectGetWidth(imageView.bounds);
    // 创建路径动画
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 设置起点,从控件顶部冒出
    [path moveToPoint:center];
    // 设置随机终点
    CGFloat endX = 0;
    CGFloat endY = 0;
    
    endX = centerX - arc4random_uniform(5 * width);
    // 往上跑
    endY = centerY - (arc4random_uniform(2) + 1) * 100;
    
    CGPoint endPoint = CGPointMake( endX, endY);
    // 设置随机曲线路径控制点
    NSInteger i = arc4random_uniform(2);
    NSInteger travelDirection = 1 - (2 * i);
    
    // 随机控制点X,Y
    CGFloat controlX = (arc4random_uniform(duration * width) / 2.0 + arc4random_uniform(2 * width)) * travelDirection;
    CGFloat controlY = MAX(endPoint.y ,MAX(arc4random_uniform(8 * width), width));
    CGPoint controlPoint1 = CGPointMake(centerX + controlX,(arc4random_uniform(2) + 1) * 100 - controlY);
    CGPoint controlPoint2 = CGPointMake(centerX - arc4random_uniform(2) * controlX, controlY);
    
    [path addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    // 路径动画
    CAKeyframeAnimation *pathAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnim.path = path.CGPath;
    pathAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnim.duration = duration + endPoint.y / 200;
    
    // 缩放动画
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    scale.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.5f],
                    [NSNumber numberWithFloat:1.5f],
                    [NSNumber numberWithFloat:0.85f],
                    [NSNumber numberWithFloat:1.5f],
                    nil];
    scale.duration = duration;
    
    // 创建动画组
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.animations = @[scale, pathAnim];
    group.duration = duration;
    group.removedOnCompletion = YES;
    group.fillMode = kCAFillModeForwards;
    // 开始动画
    [imageView.layer addAnimation:group forKey:@"positionOnPath"];
    
    // Alpha & remove from superview
    [UIView animateWithDuration:duration animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}
@end
