//
//  UIButton+XXCountDown.h
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/14.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//  倒计时按钮

#import <UIKit/UIKit.h>

@interface UIButton (CFCountDown)
/**
 *  倒计时按钮
 *
 *  @param timeLine 倒计时总时间
 *  @param title    还没倒计时的title
 *  @param subTitle 倒计时中的子名字，如时、分
 */
- (void)cf_startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle;
@end
