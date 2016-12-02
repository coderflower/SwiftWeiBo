//
//  UIView+CFExtension.m
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/2.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIView+CFExtension.h"
#import "UIView+CFFrame.h"
@implementation UIView (CFExtension)
+ (UIView *)cf_loadFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)cf_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)corner
{
    CGSize radio = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (UIViewController*)cf_viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController * )nextResponder;
        }
    }
    return nil;
}

- (UIImageView *)cf_findHairlineImageViewUnder {
    
    if ([self isKindOfClass:UIImageView.class] && self.bounds.size.height <= 1.0) {
        return (UIImageView *)self;
    }
    
    for (UIView * subview in self.subviews) {
        UIImageView * imageView = [subview cf_findHairlineImageViewUnder];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (UIView*)cf_addTopLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha {
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.cf_width,height)];
    topLine.backgroundColor = color;
    topLine.alpha = alpha;
    
    topLine.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self addSubview:topLine];
    
    NSLayoutConstraint *topContraint=[NSLayoutConstraint
                                      constraintWithItem:topLine
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                      attribute:NSLayoutAttributeTop
                                      multiplier:1.0f
                                      constant:0.0];
    NSLayoutConstraint *widthContraint=[NSLayoutConstraint
                                        constraintWithItem:topLine
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeWidth
                                        multiplier:1.0f
                                        constant:0.0];
    
    NSLayoutConstraint *heightContraint=[NSLayoutConstraint
                                         constraintWithItem:topLine
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                         constant:height];
    
    NSLayoutConstraint *leadingContraint=[NSLayoutConstraint
                                          constraintWithItem:topLine
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self
                                          attribute:NSLayoutAttributeLeading
                                          multiplier:1.0f
                                          constant:0.0];
    
    [topLine addConstraint:heightContraint];
    //给bottomLine的父节点添加约束
    [self addConstraints:@[topContraint,widthContraint,leadingContraint]];
    
    return topLine;
    
}

- (UIView*)cf_addBottomLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha {
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.cf_height- height,self.cf_width,height)];
    bottomLine.backgroundColor = color;
    bottomLine.alpha = alpha;
    bottomLine.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:bottomLine];
    
    NSLayoutConstraint *bottomContraint=[NSLayoutConstraint
                                         constraintWithItem:bottomLine
                                         attribute:NSLayoutAttributeBottom
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                         attribute:NSLayoutAttributeBottom
                                         multiplier:1.0f
                                         constant:0.0];
    NSLayoutConstraint *widthContraint=[NSLayoutConstraint
                                        constraintWithItem:bottomLine
                                        attribute:NSLayoutAttributeWidth
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                        attribute:NSLayoutAttributeWidth
                                        multiplier:1.0f
                                        constant:0.0];
    
    NSLayoutConstraint *heightContraint=[NSLayoutConstraint
                                         constraintWithItem:bottomLine
                                         attribute:NSLayoutAttributeHeight
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1.0f
                                         constant:height];
    
    NSLayoutConstraint *leadingContraint=[NSLayoutConstraint
                                          constraintWithItem:bottomLine
                                          attribute:NSLayoutAttributeLeading
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self
                                          attribute:NSLayoutAttributeLeading
                                          multiplier:1.0f
                                          constant:0.0];
    
    
    
    [bottomLine addConstraint:heightContraint];
    //给bottomLine的父节点添加约束
    [self addConstraints:@[bottomContraint,widthContraint,leadingContraint]];
    
    
    return bottomLine;
}

- (void)cf_addBottomLine:(UIColor *)color inRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
   	CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

@end
