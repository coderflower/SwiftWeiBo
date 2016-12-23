//
//  CFUser.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFUser: NSObject {
    /// 基本数据类型 & private 不能使用KVC
    var id: Int64 = 0
    /// 用户昵称
    var screen_name: String?
    /// 用户头像
    var profile_image_url: String?
    /// 认证类型 -1: 没有认证, 0: 认证用户, 2,3,5:企业认证,220:达人认证
    var verified_type: Int = 0
    /// 会员 0 - 6级
    var mbrank: Int = 0
    override var description: String {
        return yy_modelDescription()
    }
}
