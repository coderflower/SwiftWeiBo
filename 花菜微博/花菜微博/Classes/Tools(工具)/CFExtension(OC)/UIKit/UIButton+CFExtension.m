//
//  UIButton+CFExtension.m
//  
//
//  Created by 花菜ChrisCai on 2016/9/20.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIButton+CFExtension.h"
#import "NSString+CFExtension.h"
@implementation UIButton (CFExtension)
+ (UIButton *)cf_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor {
    return [self cf_textButton:title fontSize:fontSize normalColor:normalColor highlightedColor:highlightedColor backgroundImageName:nil];
}

+ (UIButton *)cf_textButton:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];
    
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    if (backgroundImageName != nil) {
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
        
        NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
        [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    }
    
    [button sizeToFit];
    
    return button;
}

+ (UIButton *)cf_imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName {
    
    UIButton *button = [[self alloc] init];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString *imageNameHL = [imageName stringByAppendingString:@"_highlighted"];
    [button setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
    
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    
    return button;
}

- (void)cf_adjustContentCenterWithSpacing:(CGFloat)spacing {
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGSize titleSize = [[self currentTitle] cf_sizeWithFont:self.titleLabel.font];
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
    
    CGRect tmpRect = self.frame;
    tmpRect.size.width = MAX(imageSize.width, titleSize.width);
    self.frame = tmpRect;
    
}
- (void)cf_adjustContentWithSpacing:(CGFloat)spacing {
    CGSize imageSize = [self imageForState:UIControlStateNormal].size;
    CGSize titleSize = [[self currentTitle] cf_sizeWithFont:self.titleLabel.font];
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0,titleSize.width + spacing, 0.0, -titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, 0.0, imageSize.width + spacing);
    CGRect tmpRect = self.frame;
    tmpRect.size.width += spacing;
    self.frame = tmpRect;
}
@end
