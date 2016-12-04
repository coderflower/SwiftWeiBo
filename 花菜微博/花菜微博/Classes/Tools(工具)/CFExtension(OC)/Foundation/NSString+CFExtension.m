//
//  NSString+CFExtension.m
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "NSString+CFExtension.h"

#import <MobileCoreServices/MobileCoreServices.h>
@implementation NSString (CFExtension)

#pragma mark -
#pragma mark - 计算label文字高度
- (CGSize)cf_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return bounds.size;
}

- (CGSize)cf_sizeWithFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f) {
        NSDictionary *attributes = @{NSFontAttributeName : font};
#ifdef __IPHONE_7_0
        size = [self sizeWithAttributes:attributes];
        size.width = ceilf(size.width);
        size.height = ceilf(size.height);
#endif
    } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font];
#pragma GCC diagnostic pop
    }
    
    return size;
}

- (CGFloat)cf_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat) lineSpacing maxWidth:(CGFloat)maxWidth {
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font ,NSParagraphStyleAttributeName:paragraph} context:nil];
    return ceilf(bounds.size.height);
}


#pragma mark -
#pragma mark - 字符串截取
- (NSString *)cf_rangeFromeStartString:(NSString *)startString toEndString:(NSString *)endString {
    
    NSRange range = [self rangeOfString:startString];
    NSString *string;
    if (range.location != NSNotFound) {
        string = [self substringFromIndex:range.location + range.length];
    }
    
    range = [string rangeOfString:endString];
    if (range.location != NSNotFound) {
        string = [string substringToIndex:range.location];
    }
    return  string;
    
}
#pragma mark -
#pragma mark - 获取文件类型
+ (NSString *)cf_mimeTypeForFileAtPath:(NSString *)path {
    
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    NSString * type = (__bridge NSString *)(MIMEType);
    CFRelease(MIMEType);
    return type;
}

#pragma mark -
#pragma mark - 清除字符串末尾0
- (NSString *)cleanDecimalPointAndZero {
    
    NSString *c = nil;
    NSInteger offset = self.length - 1;
    while (offset > 0) {
        c =[[self substringWithRange:NSMakeRange(offset, 1)] mutableCopy];
        if ([c isEqualToString:@"0"]|| [c isEqualToString:@"."]) {
            offset--;
        }else {
            break;
        }
    }
    return [self substringToIndex:offset + 1];
}


- (NSString *)cf_cleanDecimalPointAndZero {
    
    if ([self containsString:@"."]) {
        NSArray<NSString *> * arr = [self componentsSeparatedByString:@"."];
        NSString * last = [arr.lastObject cleanDecimalPointAndZero];
        if (![last isEqualToString:@"0"]) {
            return [NSString stringWithFormat:@"%@.%@",arr.firstObject,last];
        }else {
            return [NSString stringWithFormat:@"%@",arr.firstObject];
        }
    }else {
        return self;
    }
    
}


#pragma mark -
#pragma mark - 字符串转带中划线
- (NSMutableAttributedString *)cf_getMiddleLineAttriString {
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attriStr;
}


- (BOOL)isValidateMobile {
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];

}

- (BOOL)isValidateEmail {
    
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

- (BOOL)isValidateLicensePlate {
    
    NSString * licensePlateRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate * licensePlatePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",licensePlateRegex];
    return [licensePlatePredicate evaluateWithObject:self];
}

- (BOOL)isValidateCarModels {
    
    NSString * carModelsRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate * carModelsPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carModelsRegex];
    return [carModelsPredicate evaluateWithObject:self];
}

- (BOOL)isValidateUserName {
    
    NSString * userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

- (BOOL)isValidatePassword {
    
    NSString * passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate * passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL)isValidateNickname {
    
    NSString * nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate * nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [nicknamePredicate evaluateWithObject:self];
}

- (BOOL)isValidateIdentityCard {
    
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString * identityCardregex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate * identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",identityCardregex];
    return [identityCardPredicate evaluateWithObject:self];
}

+ (NSString *)cf_transform:(NSString *)chinese {
    
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}
@end
