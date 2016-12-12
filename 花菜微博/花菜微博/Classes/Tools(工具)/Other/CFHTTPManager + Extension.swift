//
//  CFHTTPManager + Extension.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit


extension CFHTTPManager {
    
    func statusList(completion: @escaping (_ list: [[String : AnyObject]]?, _ isSuccess: Bool) -> ())  {
        let token = "2.005PaBhFZEUjBBf29908d0240coBmt"
        let parameters = ["access_token" : token]
        
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
       
        CFHTTPManager.shared.request(URLString: urlString, parameters: parameters as [String : AnyObject]){(json: Any? , isSuccess: Bool) in
            let response = json as AnyObject?
            let result = response?["statuses"] as? [[String : AnyObject]]
            completion(result, isSuccess)
            
        }
    }
    
    
    
}
