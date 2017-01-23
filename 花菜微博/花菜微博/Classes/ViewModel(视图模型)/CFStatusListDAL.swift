//
//  CFStatusListDAL.swift
//  花菜微博
//
//  Created by 花菜 on 2017/1/17.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import Foundation

/**
  DAL -> Data Access Layer 数据访问层
  使命： 负责处理数据库和网络数据，给 listViewModel 返回微博的【字典数组】
  在调整系统的时候，尽量做最小化的调整
 */
class CFStatusListDAL {  
    /// 从本地或者网络加载微博数据字典数组
    ///
    /// - Parameters:
    ///   - since_id: 返回比since_id大的微博
    ///   - max_id: 返回ID小于或等于max_id的微博
    ///   - completion: 完成回调
    class func loadStatus(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String : AnyObject]]?, _ isSuccess: Bool) -> ()) {
        // 0. 获取用户 id
        guard let userId = CFNetworker.shared.userAccount.uid else {
            return
        }
        // 1. 检查本地数据，如果有直接返回
        let array = CFDBHelper.sharedHelper.loadStatus(userId: userId, since_id: since_id, max_id: max_id)
        // 1.1判断数据
        if array.count > 0 {
            // 1.2 有数据直接返回
            completion(array, true)
            return
        }
        print(max_id)
        // 2. 加载网络数据
        
        CFNetworker.shared.statusList(since_id: since_id, max_id: max_id) { (json, isSuccess) in
            if !isSuccess {
                // 2.1网络加载失败返回 nil
                completion(nil,false)
                return
            }
            guard let json = json else {
                completion(nil,isSuccess)
                return
            }
            // 3. 将网络数据【字典数组】写入数据库
            CFDBHelper.sharedHelper.updateStatus(userId: userId, array: json)
            // 4. 返回网络数据
            completion(json, isSuccess)
        }
    }
    
    
    
}
