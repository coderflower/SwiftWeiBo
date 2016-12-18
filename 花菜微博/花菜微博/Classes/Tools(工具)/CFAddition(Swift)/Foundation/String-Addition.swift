//
//  String-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation


// MARK: - 路径相关
extension String {
    
    /// 获取caches全路径
    var caches: String {
        return (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(self)
    }
    /// 获取temp全路径
    var temp: String {
        return (NSTemporaryDirectory() as NSString).appendingPathComponent(self)
    }
    /// 获取doc全路径
    var document: String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(self)
    }
    
}

