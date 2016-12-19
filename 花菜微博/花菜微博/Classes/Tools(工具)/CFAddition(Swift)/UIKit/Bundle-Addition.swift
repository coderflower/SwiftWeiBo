//
//  Bundle-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation

extension Bundle {
    public var nameSpace: String {
       return (infoDictionary?["CFBundleName"] as? String ?? "") + "."
    }
    
    public var targetVersion: String {
        return (infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
    }

}
