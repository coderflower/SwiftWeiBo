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
    var vipIcon: UIImage?
    
    init(model: CFStatus) {
        self.status = model
        if let mbrank = model.user?.mbrank {
            if mbrank > 0 && mbrank < 7 {
                let imageName = "common_icon_membership_level" + "\(mbrank)"
                memberIcon = UIImage(named: imageName)
            }
        }
        // 认证类型 -1: 没有认证, 0: 认证用户, 2,3,5:企业认证,220:达人认证
        switch model.user?.verified_type ?? -1{
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
    var description: String {
        return self.status.description
    }
    
}
