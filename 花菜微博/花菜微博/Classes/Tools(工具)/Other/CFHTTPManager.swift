//
//  CFHTTPManager.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod {
    case GET
    case POST
}

class CFHTTPManager: AFHTTPSessionManager {
    
    static let shared : CFHTTPManager = {
        // 实例化对象
        let instance = CFHTTPManager()
        
        // 设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        // 返回对象
        return instance
    }()
    
    var accessToken: String? = "2.005PaBhF2ylxHC6865a6e00cA8lMbC"
    var uid: String? = "5365823342"
    
    
    func tokenRequest(method: HTTPMethod = .GET, URLString: String, parameters: [String : AnyObject]? ,completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) -> () {
        // 处理token
        guard let token = accessToken else {
            print("token 为 nil!, 请重新登录")
            // FIXME: 发送通知,提示用户登录
            completion(nil, false)
            return
        }
        // 判断parameters是否有值
        var parameters = parameters
        if parameters == nil {
            parameters = [String : AnyObject]()
        }
        // 此处parameters一定有值
        parameters!["access_token"] = token as AnyObject?
        
        request(method: method, URLString: URLString, parameters: parameters, completion: completion)
    }
    
    
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String : AnyObject]? ,completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) -> (){
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any?)->() in            
            completion(json as AnyObject, true)
        }
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            // 针对403处理用户token过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token 已过期")
                // FIXME: 发送通知,提示用户重新登录(本方法不知道谁被调用,谁接手通知,谁处理)
            }
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
