//
//  UIScreen+CFExtension.m
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIScreen+CFExtension.h"

@implementation UIScreen (CFExtension)
+ (CGFloat)cf_screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)cf_screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)cf_scale {
    return [UIScreen mainScreen].scale;
}
@end
