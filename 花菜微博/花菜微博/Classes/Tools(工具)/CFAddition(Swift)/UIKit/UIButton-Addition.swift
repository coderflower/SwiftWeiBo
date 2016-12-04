//
//  UIButton-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

extension UIButton {
    
    
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 按钮标题
    ///   - fontSize: 按钮字体大小
    ///   - color: 按钮普通状态颜色,默认为黑色
    ///   - highlighterColor: 按钮高亮状态颜色,默认为白色
    ///   - backgroundImage: 按钮背景图片
    convenience init(title: String, fontSize: CGFloat = 14,color: UIColor = UIColor.black, highlighterColor: UIColor = UIColor.white, backgroundImageName: String = "") {
        self.init()
        
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(highlighterColor, for: .highlighted)
        self.setTitleColor(highlighterColor, for: .selected)
        self.setBackgroundImage(UIImage(named:backgroundImageName), for: .normal)
        self.sizeToFit()
    }
    
    /// 创建图片按钮,按钮图片的名字一定要闺房
    ///
    /// - Parameters:
    ///   - imageName: 普通状态下图片名字
    ///   - backgroundImageName: 按钮背景图片
    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        self.setImage(UIImage(named:imageName), for: .normal)
        self.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        self.setImage(UIImage(named:imageName + "_selected"), for: .selected)
        self.setBackgroundImage(UIImage(named:backgroundImageName), for: .normal)
        self.sizeToFit()
    }
    
}
