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
    /// token过期时间
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户uid
    var uid: String?
    var expiresDate: Date?
    
    override var description: String {
        return yy_modelDescription()
    }
}
