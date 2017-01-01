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
    
    
    func calculateSize(lineSpace: CGFloat = 0) -> CGSize {
        var attri = [String: AnyObject]()
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = lineSpace
        attri[NSFontAttributeName] = font
        attri[NSParagraphStyleAttributeName] = paragraph
        let size = CGSize(width: self.preferredMaxLayoutWidth, height: CGFloat(MAXFLOAT))
        if let text = text {
           return (text as NSString).boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attri, context: nil).size
        }
        return CGSize.zero
    }
}
