//
//  UIImageView+CFExtension.m
//  Meifabao
//
//  Created by mac on 2016/10/14.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import "UIImageView+CFExtension.h"

@implementation UIImageView (CFExtension)
// 播放GIF
- (void)cf_playGifAnim:(NSArray *)images {
    if (!images.count) {
        return;
    }
    //动画图片数组
    self.animationImages = images;
    //执行一次完整动画所需的时长
    self.animationDuration = 0.5;
    //动画重复次数, 设置成0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}
// 停止动画
- (void)cf_stopGifAnim {
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}
@end
