//
//  UIView+XXAnimation.h
//  
//
//  Created by 花菜ChrisCai on 2016/9/20.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIView (CFAnimation)
/**
 *  从底部升起出现
 */
- (void)cf_showFromBottom;

/**
 *  消失降到底部
 */
- (void)cf_dismissToBottomWithCompleteBlock:(void(^)())completeBlock;

/**
 *  从透明到不透明
 */
- (void)cf_emerge;

/**
 *  从不透明到透明
 */
- (void)cf_fake;

/**
 *  按钮震动动画
 */
- (void)cf_startSelectedAnimation;

/**
 *  点赞放大动画
 */
- (void)cf_praiseEnlarge;

/**
 粒子动画
 谁调用就以谁的上面发射

 @param images      动画图片数组
 @param inView      动画添加到哪个控件
 @param repeatTime 动画持续时间,如果为0则不删除
 */
- (void)cf_emitterAnimationWithImages:(NSArray <UIImage *> *)images inView:(UIView *)inView repeatTime:(NSTimeInterval)repeatTime ;
- (void)cf_emitterAnimationWithImage:(UIImage *)image inView:(UIView *)inView repeatTime:(NSTimeInterval)repeatTime;
- (void)cf_animationInView:(UIView *)inView image:(UIImage *)image center:(CGPoint)center duration:(NSTimeInterval)duration;
@end
