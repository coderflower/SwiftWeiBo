//
//  UIResponder+CFExtension.h
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/17.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (CFExtension)

- (void)cf_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end
