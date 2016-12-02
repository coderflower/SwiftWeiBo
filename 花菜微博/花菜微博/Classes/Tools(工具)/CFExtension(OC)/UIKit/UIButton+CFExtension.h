//
//  UIButton+CFExtension.h
//  
//
//  Created by 花菜ChrisCai on 2016/9/20.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CFExtension)
/**
 创建文本按钮
 
 @param title            标题文字
 @param fontSize         字体大小
 @param normalColor      默认颜色
 @param highlightedColor 高亮颜色
 
 @return UIButton
 */
+ (UIButton *)cf_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor;


/**
 创建文本按钮
 
 @param title               标题文字
 @param fontSize            字体大小
 @param normalColor         默认颜色
 @param highlightedColor    高亮颜色
 @param backgroundImageName 背景图像名称
 
 @return UIButton
 */
+ (UIButton *)cf_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName;

/**
 创建图像按钮
 
 @param imageName           图像名称
 @param backgroundImageName 背景图像名称
 
 @return UIButton
 */
+ (UIButton *)cf_imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName;

/**
 按钮上下居中

 @param spacing 图片与文字的上下间距
 */
- (void)cf_adjustContentCenterWithSpacing:(CGFloat)spacing;
/**
 按钮反向(图片在右边)
 
 @param spacing 图片与文字的左右间距
 */
- (void)cf_adjustContentWithSpacing:(CGFloat)spacing;
@end
