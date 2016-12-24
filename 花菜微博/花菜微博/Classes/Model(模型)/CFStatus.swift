//
//  CFStatus.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import YYModel
class CFStatus: NSObject {
    /// 微博ID
    var id: Int64 = 0
    /// 微博正文
    var text: String?
    /// 用户
    var user: CFUser?
    /// 配图
    var pic_urls: [CFStatusPicture]?
    /// 转发数
    var reposts_count: Int = 0
    /// 评论数
    var comments_count: Int = 0
    /// 点赞数
    var attitudes_count: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls": CFStatusPicture.self]
    }
}
