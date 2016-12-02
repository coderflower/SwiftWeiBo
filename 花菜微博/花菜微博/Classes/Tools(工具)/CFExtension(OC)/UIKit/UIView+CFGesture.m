//
//  UIView+XXGesture.m
//  Meifabao
//
//  Created by 花菜ChrisCai on 2016/9/6.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import "UIView+CFGesture.h"

#import <objc/runtime.h>

static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerLongPressBlockKey;

@implementation UIView (XXGesture)
- (void)cf_setTapActionWithBlock:(void (^)(void))block {
    // 开启用户交互
    self.userInteractionEnabled = YES;
    // 创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAction:)];
    // 添加手势
    [self addGestureRecognizer:tap];
    // 保存回调
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)_tapAction:(UITapGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)cf_setLongPressActionWithBlock:(void (^)(void))block {
    // 创建手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(_LongPressAction:)];
    // 添加手势
    [self addGestureRecognizer:longPress];
    // 保存回调
    objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)_LongPressAction:(UITapGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan)  {
        
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
        if (action) {
            action();
        }
    }
}

@end
