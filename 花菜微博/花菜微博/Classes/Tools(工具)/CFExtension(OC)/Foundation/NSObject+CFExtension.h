//
//  NSObject+CFExtension.h
//  Meifabao
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocation;
@interface NSObject (CFExtension)

/**
 获取用户定位授权状态,如果为拒绝则返回对应的跳转URL
 根据返回的url跳转到响应的界面,如果返回的url为空则表示用户已经授权
 @return 跳转的设置界面的URL
 */
- (NSURL *)cf_getLocationSettingURL;


- (double)cf_distanceBetweenCurrentLoc:(CLLocation *)currentLoc andOtherLoc:(CLLocation *)otherLoc ;
- (double)cf_distanceBetweenCurentLon:(double)curentLon curentLat:(double)curentLat otherLon:(double)otherLon otherLat:(double)otherLat ;
@end
