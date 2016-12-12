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
    
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String : AnyObject] ,completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any?)->() in            
            completion(json, true)
        }

        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
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
