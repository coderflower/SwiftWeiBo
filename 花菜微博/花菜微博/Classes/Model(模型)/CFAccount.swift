//
//  CFAccount.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/18.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
/// 存储用户账号信息的文件名
private let userAccountPath = "useraccount.json".document

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
    var screen_name: String?
    var avatar_large: String?
    
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        // 从沙盒加载用户信息
        guard let data = NSData(contentsOfFile: userAccountPath),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String : AnyObject]
            else {
             return
        }
        // 字典转模型
        yy_modelSet(with: dict ?? [:])
        // 判断token是否过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("提醒用户token过期")
            // 清空token,uid,删除用户信息文件
            access_token = nil
            uid = nil
            try? FileManager.default.removeItem(atPath: userAccountPath)
        }
        print("账户正常")
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
}
