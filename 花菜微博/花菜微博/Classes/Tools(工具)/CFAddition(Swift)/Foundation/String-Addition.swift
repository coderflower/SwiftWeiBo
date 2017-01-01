//
//  String-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit


// MARK: - 路径相关
extension String {
    
    /// 获取caches全路径
    var caches: String {
        return (NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(self)
    }
    /// 获取temp全路径
    var temp: String {
        return (NSTemporaryDirectory() as NSString).appendingPathComponent(self)
    }
    /// 获取doc全路径
    var document: String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(self)
    }
    
}


// MARK: - 计算文本矩形框尺寸
extension String {
    
    /// 根据文本计算其尺寸
    ///
    /// - Parameter font: 文本使用的字体
    /// - Returns: 文本尺寸
    func cf_size(font: UIFont) -> CGSize {
        var size = CGSize.zero
        let attributes = [NSFontAttributeName: font]
        size = (self as NSString).size(attributes: attributes)
        size.width = CGFloat(ceilf(Float(size.width)))
        size.height = CGFloat(ceilf(Float(size.height)))
        return size
    }

    func calculateSize(font: UIFont,maxWidth: CGFloat = UIScreen.main.cf_screenWidth) -> CGSize {
        let size = CGSize(width: maxWidth, height: CGFloat(MAXFLOAT))
        return (self as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil).size
        
    }

    
}

