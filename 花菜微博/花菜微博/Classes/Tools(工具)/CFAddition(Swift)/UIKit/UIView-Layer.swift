//
//  UIView-Layer.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/20.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit


// MARK: - layer相关属性
extension UIView {
    
    var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.white.cgColor)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.masksToBounds = true;
            // 栅格化优化性能
            self.layer.rasterizationScale = UIScreen.main.scale;
            self.layer.shouldRasterize = true;
            self.layer.cornerRadius = newValue
        }
    }

    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}


extension UIView {
    
}
