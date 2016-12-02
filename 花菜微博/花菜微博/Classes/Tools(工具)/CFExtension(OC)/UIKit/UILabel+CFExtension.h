//
//  UILabel+CFExtension.h
//  Meifabao
//
//  Created by mac on 2016/10/10.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CFExtension)

+ (UILabel *)label;

- (UILabel *)set;

- (UILabel *(^)(NSString *))cf_text;

- (UILabel *(^)(UIColor *))cf_textColor;

- (UILabel *(^)(NSTextAlignment))cf_textAlignment;

- (UILabel *(^)(UIFont *))cf_font;

- (UILabel *(^)(NSInteger))cf_numberOfLines;

/**
 创建文本标签

 @param text 文本
 @param fontSize 字体大小
 @param color 颜色
 @return 文本label
 */
+ (UILabel *)cf_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color;
@end
