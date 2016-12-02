//
//  NSArray+CFExtension.m
//  Meifabao
//
//  Created by 花菜ChrisCai on 2016/9/18.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import "NSArray+CFExtension.h"

@implementation NSArray (CFExtension)

/*!
 *  @author ChrisCai, 16-09-18
 *
 *  @brief 将数组随机打乱
 */
- (NSArray *)cf_randomArray {
    // 转为可变数组
    NSMutableArray * tmp = self.mutableCopy;
    // 获取数组长度
    NSInteger count = tmp.count;
    // 开始循环
    while (count > 0) {
        // 获取随机角标
        NSInteger index = arc4random_uniform((int)(count - 1));
        // 获取角标对应的值
        id value = tmp[index];
        // 交换数组元素位置
        tmp[index] = tmp[count - 1];
        tmp[count - 1] = value;
        count--;
    }
    // 返回打乱顺序之后的数组
    return tmp.copy;
}

@end
