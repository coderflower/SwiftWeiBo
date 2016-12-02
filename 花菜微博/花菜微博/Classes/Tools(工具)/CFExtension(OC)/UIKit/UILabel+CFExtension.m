//
//  UILabel+CFExtension.m
//  Meifabao
//
//  Created by mac on 2016/10/10.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import "UILabel+CFExtension.h"
@implementation UILabel (CFExtension)

+ (UILabel *)label {
    return [[self alloc]init];
}

- (UILabel *)set {
    return self;
}

- (UILabel *(^)(NSString *))cf_text {
    return ^(NSString * text) {
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(UIColor *))cf_textColor {
    return ^(UIColor * textColor) {
        self.textColor = textColor;
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment))cf_textAlignment {
    return ^(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

- (UILabel *(^)(UIFont *))cf_font {
    return ^(UIFont * font) {
        self.font = font;
        return self;
    };
}

- (UILabel *(^)(NSInteger))cf_numberOfLines {
    return ^(NSInteger numberOfLines) {
        self.numberOfLines = numberOfLines;
        return self;
    };
}

- (void)setAttributes {
    
}
+ (UILabel *)cf_labelWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color {
    
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = color;
    label.numberOfLines = 0;
    [label sizeToFit];
    return label;
}



@end
