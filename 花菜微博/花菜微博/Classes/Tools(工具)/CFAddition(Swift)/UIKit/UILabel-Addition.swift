//
//  UILabel-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, fontSize: CGFloat = 14, textColor: UIColor = UIColor.darkGray, lines: Int = 0) {
        self.init()
        self.text = text;
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textColor = textColor
        self.numberOfLines = lines
    }
}
