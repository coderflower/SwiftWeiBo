//
//  String-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/19.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

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
}
