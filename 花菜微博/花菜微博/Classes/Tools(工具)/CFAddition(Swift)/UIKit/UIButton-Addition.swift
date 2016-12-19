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
    
    
    /// 快速排版并重新计算尺寸
    ///
    /// - Parameters:
    ///   - isHorizontal: 是否是水平排版,默认为水平即文字在左边,图片在右边
    ///   - margin: 图片与文字之间的间距
    func adjustContent(isHorizontal: Bool = true, margin: CGFloat) {
        guard let imageSize = self.image(for: .normal)?.size,
            let title = self.currentTitle
            else {
                return
        }
        // 计算文字尺寸
        let titleSize = title.cf_size(font: self.titleLabel!.font)
        var tmpRect = self.frame
        if isHorizontal {
            // 文字左边,图片右边
            self.imageEdgeInsets = UIEdgeInsets(top: 0,
                                                left: titleSize.width + margin,
                                                bottom: 0,
                                                right: -titleSize.width)
            self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                left: -imageSize.width,
                                                bottom: -0,
                                                right: imageSize.width + margin)
            tmpRect.size.width += margin;
        } else {
            // 图片上面啊,文字下面
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + margin),
                                                left: 0,
                                                bottom: 0,
                                                right: -titleSize.width)
            self.titleEdgeInsets = UIEdgeInsets(top: 0,
                                                left: -imageSize.width,
                                                bottom:  -(imageSize.height + margin),
                                                right: 0)
            tmpRect.size.width = max(imageSize.width, titleSize.width);
        }
        self.frame = tmpRect
    }
}
