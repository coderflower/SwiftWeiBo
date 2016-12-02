//
//  UIScreen+CFExtension.h
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (CFExtension)
/// 屏幕宽度
+ (CGFloat)cf_screenWidth;
/// 屏幕高度
+ (CGFloat)cf_screenHeight;
/// 分辨率
+ (CGFloat)cf_scale;
@end
