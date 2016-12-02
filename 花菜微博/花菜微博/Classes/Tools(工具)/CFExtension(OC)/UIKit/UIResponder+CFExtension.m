//
//  UIResponder+CFExtension.m
//  Caiflower
//
//  Created by 花菜ChrisCai on 2016/7/17.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

#import "UIResponder+CFExtension.h"

@implementation UIResponder (CFExtension)
- (void)cf_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] cf_routerEventWithName:eventName userInfo:userInfo];
}
@end
