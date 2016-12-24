//
//  CFStatusViewModel.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation

/// 微博视图模型
/**
如果没有任何父类,如果希望在开发时调试,输出调试信息
1. 遵守 CustomStringConvertible 协议
2. 实现 description 计算属性
 
 */
class CFStatusViewModel: CustomStringConvertible {
    
    /// 模型数据
    var status: CFStatus
    /// 会员图标
    var memberIcon: UIImage?
    /// 认证图标
    var vipIcon: UIImage?
    var retweetStr: String?
    var commentStr: String?
    var likeStr: String?
    
    init(model: CFStatus) {
        self.status = model
        setMemberlevel()
        setVerifiedType()
        setCountStrin()
    }
    
    
    /// 设置会员等级
    func setMemberlevel() {
        if let mbrank = self.status.user?.mbrank {
            if mbrank > 0 && mbrank < 7 {
                let imageName = "common_icon_membership_level" + "\(mbrank)"
                memberIcon = UIImage(named: imageName)
            }
        }
    }
    
    /// 设置用户认证类型
    fileprivate func setVerifiedType() {
        // 认证类型 -1: 没有认证, 0: 认证用户, 2,3,5:企业认证,220:达人认证
        switch self.status.user?.verified_type ?? -1{
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
    }
    
    fileprivate func setCountStrin() {
        retweetStr = countString(count: self.status.reposts_count, defaultString: "转发")
        commentStr = countString(count: self.status.comments_count, defaultString: "评论")
        likeStr = countString(count: self.status.attitudes_count, defaultString: "赞")
    }
    
    /// 设置转发,评论,点赞的描述
    ///
    /// - Parameters:
    ///   - count: 转发,评论,点赞的数量
    ///   - defaultString: 默认文字
    /// - Returns: 描述文字
   fileprivate func countString(count: Int, defaultString: String) -> String {
        if count == 0 {
            return defaultString
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.2f 万", Double(count) / 10000)
    }
    
    var description: String {
        return self.status.description
    }
    
    
    
    
}
