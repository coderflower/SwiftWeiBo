//
//  CFHTTPManager + Extension.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit


extension CFHTTPManager {
    
    /// 加载微博数据字典数组
    ///
    /// - Parameters:
    ///   - since_id: 返回比since_id大的微博
    ///   - max_id: 返回ID小于或等于max_id的微博
    ///   - completion: 完成回调
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String : AnyObject]]?, _ isSuccess: Bool) -> ())  {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        // Swift中Int类型可以直接转换成AnyObject 但是Int64不行
        let parameters = ["since_id": "\(since_id)", "max_id": "\(max_id)"]
        
        CFHTTPManager.shared.tokenRequest(URLString: urlString, parameters: parameters as [String : AnyObject]?){(json: Any? , isSuccess: Bool) in
            let response = json as AnyObject?
            let result = response?["statuses"] as? [[String : AnyObject]]
            completion(result, isSuccess)
        }
    }
}
