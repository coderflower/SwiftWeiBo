//
//  UIImageView+CFExtension.h
//  Meifabao
//
//  Created by mac on 2016/10/14.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (CFExtension)
// 播放GIF
- (void)cf_playGifAnim:(NSArray *)images;
// 停止动画
- (void)cf_stopGifAnim;
@end
