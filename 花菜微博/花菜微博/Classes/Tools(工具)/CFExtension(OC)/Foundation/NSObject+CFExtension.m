//
//  NSObject+CFExtension.m
//  Meifabao
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 杭州丝黛丽网络科技有限公司. All rights reserved.
//

#import "NSObject+CFExtension.h"
#import <CoreLocation/CoreLocation.h>
@implementation NSObject (CFExtension)
- (NSURL *)cf_getLocationSettingURL {
    
    NSURL * url = nil;
     CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if ([CLLocationManager locationServicesEnabled] == NO) {
        url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    }else if( authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    }
    return url;
}

- (double)cf_distanceBetweenCurrentLoc:(CLLocation *)currentLoc andOtherLoc:(CLLocation *)otherLoc {
    return [self cf_distanceBetweenCurentLon:currentLoc.coordinate.longitude curentLat:currentLoc.coordinate.latitude otherLon:otherLoc.coordinate.longitude otherLat:otherLoc.coordinate.latitude];
}

- (double)cf_distanceBetweenCurentLon:(double)curentLon curentLat:(double)curentLat otherLon:(double)otherLon otherLat:(double)otherLat {
    double dd = M_PI/180;
    double x1 = curentLat * dd,x2 = otherLat * dd;
    double y1 = curentLon * dd,y2 = otherLon * dd;
    double R = 6371.004;
    double distance = (2 * R * asin(sqrt(2 - 2 * cos(x1) * cos(x2) * cos(y1 - y2) - 2 * sin(x1) * sin(x2)) / 2));
    //返回 km
    return  distance;
}

@end
