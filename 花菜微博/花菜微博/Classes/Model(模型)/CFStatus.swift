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
    /// 被转发的微博
    var retweeted_status: CFStatus?
    /// 微博创建时间
    var created_at: String?
    /// 微博来源
    var source: String? {
        didSet {
            if let str = self.sourceRegular(string: source)?.text {
                source = "来自 \(str)"
            }
            else {
                source = nil
            }
        }
    }
    
    override var description: String {
        return yy_modelDescription()
    }
    
    /// YYModel 属性映射字典
    ///
    /// - Returns: 属性映射关系
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls": CFStatusPicture.self]
    }
    
    
    func sourceRegular(string: String?) -> (link: String, text: String)?  {
        // 创建匹配规则
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        // 根据匹配规则创建正则表达式
        guard let string = string,
            let regular = try? NSRegularExpression(pattern: pattern, options: []),
            let result =  regular.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.characters.count)) else {
                return nil
        }
        // 获取结果
        let link = (string as NSString).substring(with: result.rangeAt(1))
        let text = (string as NSString).substring(with: result.rangeAt(2))
        
        return (link, text)
    }
    
}
