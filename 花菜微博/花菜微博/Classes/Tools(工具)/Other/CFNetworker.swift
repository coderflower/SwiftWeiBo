//
//  CFNetworker.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD
enum HTTPMethod {
    case GET
    case POST
}

class CFNetworker: AFHTTPSessionManager {
    // 用户信息
    lazy var userAccount = CFAccount()
    
    static let shared : CFNetworker = {
        // 实例化对象
        let instance = CFNetworker()
        
        // 设置响应反序列化支持的数据类型
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        // 返回对象
        return instance
    }()
    
    var authorizeUrlString: String {
        return "https://api.weibo.com/oauth2/authorize" + "?" + "client_id=\(SinaAppKey)" + "&" + "redirect_uri=\(SinaRedirectURI)"
    }
    
    var userLogon: Bool {
        return userAccount.access_token != nil
    }
    func tokenRequest(method: HTTPMethod = .GET, URLString: String, parameters: [String : AnyObject]? ,completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) -> ()) -> () {
        // 处理token
        guard let token = userAccount.access_token else {
            print("token 为 nil!, 请重新登录")
            // FIXME: 发送通知,提示用户登录
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserShoudLoginNotification), object: "bad token")
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
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: "正在加载请稍后")
        // 成功回调
        let success = { (task: URLSessionDataTask, json: Any?)->() in            
            completion(json as AnyObject, true)
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.clear)
        }
        // 失败回调
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            // 针对403处理用户token过期
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token 已过期")
                // FIXME: 发送通知,提示用户重新登录(本方法不知道谁被调用,谁接手通知,谁处理)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kUserShoudLoginNotification), object: "bad token")
            }
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.showError(withStatus: "网络加载失败,请稍后重试")
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
