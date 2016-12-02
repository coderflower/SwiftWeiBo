//
//  UIView+XXGesture.h
//  Meifabao
//
//  Created by 花菜ChrisCai on 2016/9/6.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XXGesture)
/**
 *  给view添加单击手势
 *
 *  @param block 单击手势执行的block
 */
- (void)cf_setTapActionWithBlock:(void (^)(void))block;

/**
 *  给view添加长按手势
 *
 *  @param block 长按手势执行的block
 */
- (void)cf_setLongPressActionWithBlock:(void (^)(void))block;
@end
