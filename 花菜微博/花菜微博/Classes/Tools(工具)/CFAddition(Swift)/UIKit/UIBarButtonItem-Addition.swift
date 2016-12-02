//
//  UIBarButtonItem-Extension.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 自定义UIBarButtonItem构造器
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - fontSize: 文字大小,默认16
    ///   - target: target
    ///   - action: action
    ///   - isBack: 是否是返回按钮,如果是加上箭头
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?,action: Selector, isBack: Bool = false) {
        let btn : UIButton = UIButton.cf_textButton(title, fontSize: fontSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            btn.sizeToFit()
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView:btn)
    }
}
