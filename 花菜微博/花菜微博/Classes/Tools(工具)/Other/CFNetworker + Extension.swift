//
//  CFNetworker + Extension.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit


extension CFNetworker {
    
    /// 加载微博数据字典数组
    ///
    /// - Parameters:
    ///   - since_id: 返回比since_id大的微博
    ///   - max_id: 返回ID小于或等于max_id的微博
    ///   - completion: 完成回调
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String : AnyObject]]?, _ isSuccess: Bool) -> ())  {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        // Swift中Int类型可以直接转换成AnyObject 但是Int64不行
        let parameters = ["since_id": "\(since_id)", "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        // 请求数据
        CFNetworker.shared.tokenRequest(URLString: urlString, parameters: parameters as [String : AnyObject]?){(json: Any? , isSuccess: Bool) in
            let response = json as AnyObject?
            let result = response?["statuses"] as? [[String : AnyObject]]
            completion(result, isSuccess)
        }
    }
    
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        guard let uid = userAccount.uid else {
            return
        }
        let urlString = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let parameters = ["uid": uid as AnyObject] as [String : AnyObject]
        CFNetworker.shared.tokenRequest(URLString: urlString, parameters: parameters) { (json, isSuccess) in
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int
            completion(count ?? 0)
        }
    }
}

// MARK: - 加载用户信息
extension CFNetworker {
    /// 加载当前用户信息,用户登录成功后立即执行
    func loadUserInfo(completion: @escaping (_ dict: [String: AnyObject]) -> ()) {
        guard let uid = userAccount.uid else {
            NotificationCenter.default.post(name:  NSNotification.Name(rawValue: kUserShoudLoginNotification), object: "bad token")
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        let parameters = ["uid": uid]
        tokenRequest(URLString: urlString, parameters: parameters as [String : AnyObject]?) { (json, isSuccess) in
            print(json ?? "登录失败")
            completion(json as? [String: AnyObject] ?? [:])
        }
        
    }
}

// MARK: - 发微博
extension CFNetworker {
   
    func postStatus(text: String, completion: @escaping (_ dict: [String: AnyObject]?, _ isSuccess: Bool) -> ()) {
       
        let urlString = "https://api.weibo.com/2/statuses/update.json"
        let parameters = ["status": text]
        tokenRequest(method: .POST, URLString: urlString, parameters: parameters as [String : AnyObject]?) { (json, isSuccess) in
            completion(json as? [String: AnyObject], isSuccess)
        }
        
    }

    
}


// MARK: - OAuth相关方法
extension CFNetworker {
    /// 请求AccessToken
    func requestToken(code: String, completion:@escaping (_ isSuccess: Bool) ->()) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        let parameters = [
            "client_id": SinaAppKey,
            "client_secret": SinaAppSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": SinaRedirectURI
                        ]
        request(method: .POST, URLString: urlString, parameters: parameters as [String : AnyObject]?) { (json, isSuccess) in
            print(json ?? "")
            // 字典转模型
            self.userAccount.yy_modelSet(with: json as? [String : AnyObject] ?? [:])
            // 加载当前用户信息
            self.loadUserInfo(completion: { (dict) in
                // 设置昵称,头像地址
                self.userAccount.yy_modelSet(with: dict)
                // 保存用户信息
                self.userAccount.saveAccount()
                print(self.userAccount)
                // 用户信息加载完毕再请求
                completion(isSuccess)
            })
        }
    }
}
