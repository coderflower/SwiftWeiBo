//
//  UIView+CFExtension.h
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIView+XXFrame.h"
//IB_DESIGNABLE
@interface UIView (CFExtension)
/// 边线颜色
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

/// 边线宽度
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

/// 圆角半径
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

/// 从XIB加载控件
+ (UIView *)cf_loadFromXib;
/**
 *  局部圆角半径
 *
 *  @param cornerRadius 圆角半径大小
 *  @param corner       圆角半径位置
 */
- (void)cf_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)corner;

/// 获取一个view的控制器
- (UIViewController*)cf_viewController;
/// 寻找1像素的线(可以用来隐藏导航栏下面的黑线）
- (UIImageView *)cf_findHairlineImageViewUnder;
/// 添加顶部分割线
- (UIView*)cf_addTopLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha;
/// 添加底部分割线
- (UIView*)cf_addBottomLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha;
- (void)cf_addBottomLine:(UIColor *)color inRect:(CGRect)rect;
@end
