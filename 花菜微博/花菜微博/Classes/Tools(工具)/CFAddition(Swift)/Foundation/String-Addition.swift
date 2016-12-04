//
//  String-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation

extension String {
    
    /// 获取caches全路径
    func cf_caches() -> String {
        let path = (self as NSString).lastPathComponent
        let cachesPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0]
        return (cachesPath as NSString).appendingPathComponent(path)
    }
    /// 获取temp全路径
    func cf_temp() -> String {
        let path = (self as NSString).lastPathComponent
        let tempPath = NSTemporaryDirectory()
        return (tempPath as NSString).appendingPathComponent(path)
    }
    /// 获取doc全路径
    func cf_doc() -> String {
        let path = (self as NSString).lastPathComponent
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return (docPath as NSString).appendingPathComponent(path)
    }
}

