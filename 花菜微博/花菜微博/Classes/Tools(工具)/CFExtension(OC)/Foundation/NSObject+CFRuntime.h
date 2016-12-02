//
//  NSObject+CFRuntime.h
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CFRuntime)
/// 使用字典数组创建当前类对象的数组
///
/// @param array 字典数组
///
/// @return 当前类对象的数组
+ (NSArray *)cf_objectsWithArray:(NSArray *)array;

/// 返回当前类的属性数组
///
/// @return 属性数组
+ (NSArray *)cf_propertiesList;

/// 返回当前类的成员变量数组
///
/// @return 成员变量数组
+ (NSArray *)cf_ivarsList;
@end
