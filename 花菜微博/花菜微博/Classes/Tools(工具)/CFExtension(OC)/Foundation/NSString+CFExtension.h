//
//  NSString+CFExtension.h
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (CFExtension)

/**
 计算文本高度
 
 @param font 文本所使用的字体
 @param maxWidth 最大宽度
 @return 文本的宽高
 */
- (CGSize)cf_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 根据字体计算文字尺寸

 @param font 字体

 @return 文字尺寸
 */
- (CGSize)cf_sizeWithFont:(UIFont *)font;
/**
 计算文字高度
 
 @param font        文本所使用的字体
 @param lineSpacing 行间距
 @param maxWidth    最大宽度
 
 @return 文本所占用的高度
 */
- (CGFloat)cf_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat) lineSpacing maxWidth:(CGFloat)maxWidth;

/**
 *  截取指定范围内的字符串
 *
 *  @param startString 起始位置
 *  @param endString   结束位置
 *
 */
- (NSString *)cf_rangeFromeStartString:(NSString *)startString toEndString:(NSString *)endString;
/**
 *  获取MIMEType
 *
 *  @param path 文件路径
 *
 *  @return MIMEType
 */
+ (NSString *)cf_mimeTypeForFileAtPath:(NSString *)path;
/**
 *  清除字符串小数点末尾的0
 *
 *  @return 新的字符串
 */
- (NSString *)cf_cleanDecimalPointAndZero;

/**
 *  根据一个字符串返回一个带有中划线的富文本
 *
 */
- (NSMutableAttributedString *)cf_getMiddleLineAttriString;
/*!
 *  @author ChrisCai, 16-09-06
 *
 *  @brief 中文转拼音
 *
 *  @param chinese 中文字符串
 *
 *  @return 拼音
 */
+ (NSString *)cf_transform:(NSString *)chinese;
- (BOOL)isValidateMobile;

- (BOOL)isValidateEmail;

- (BOOL)isValidateLicensePlate;

- (BOOL)isValidateCarModels;

- (BOOL)isValidateUserName;

- (BOOL)isValidatePassword;

- (BOOL)isValidateNickname;

- (BOOL)isValidateIdentityCard;

@end
