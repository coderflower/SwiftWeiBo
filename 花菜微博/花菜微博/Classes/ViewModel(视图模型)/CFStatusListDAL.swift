//
//  CFStatusListDAL.swift
//  花菜微博
//
//  Created by 花菜 on 2017/1/17.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import Foundation

/**
 
 */

class CFStatusListDAL {
    
    
    /// 从本地或者网络加载微博数据字典数组
    ///
    /// - Parameters:
    ///   - since_id: 返回比since_id大的微博
    ///   - max_id: 返回ID小于或等于max_id的微博
    ///   - completion: 完成回调
    class func loadStatus(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String : AnyObject]]?, _ isSuccess: Bool) -> ()) {
        // 检查本地数据，如果有直接返回
        // 加载网络数据
        // 将网络数据【字典数组】写入数据库
        // 返回网络数据
        
    }
    
    
    
}
