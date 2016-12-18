//
//  CFAccount.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/18.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFAccount: NSObject {
    /// 访问令牌
    var access_token: String?
    /// token声明周期
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户uid
    var uid: String?
    /// 过期时间
    var expiresDate: Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    
    /*
     1. 偏好设置
     2. 沙盒 - 归档/plist
     3. 数据库
     4. 钥匙串(SSKeychain框架)
     */
    /// 保存用户信息
    func saveAccount() {
        // 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
        // 移除不必要的值
        dict .removeValue(forKey: "expires_in")
        // 转换为二进制,保存到沙盒
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            return
        }
        // 保存用户信息
        (data as NSData).write(toFile: userAccountPath, atomically: true)
    }
    
    /// 从沙盒中读取本地用户信息
    ///
    /// - Returns: 本地用户信息
    class func loadAccount() -> CFAccount {
        // 从沙盒中读取用户信息(二进制文件)
        guard let data = NSData(contentsOfFile: userAccountPath) else {
            return CFAccount()
        }
        // 转换成json字符串
        let json = try? JSONSerialization.jsonObject(with: data as Data, options: [])
        let account = CFAccount()
        // 字典转模型
        account.yy_modelSet(with: json as? [String : AnyObject] ?? [:])
        return account
    }
}
