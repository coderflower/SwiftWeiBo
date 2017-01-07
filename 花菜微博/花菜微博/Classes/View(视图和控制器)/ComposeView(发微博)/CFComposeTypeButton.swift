//
//  CFComposeTypeButton.swift
//  花菜微博
//
//  Created by 花菜Caiflower on 2017/1/7.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFComposeTypeButton: UIControl {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    var className: String?
    convenience init(imageName: String, title: String) {
        self.init()
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)
        setupOwenView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: (bounds.width - 71) * 0.5,
                                 y: 0,
                                 width: 71,
                                 height: 71)
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: (bounds.width - titleLabel.bounds.width) * 0.5,
                                  y: bounds.height - titleLabel.bounds.height,
                                  width: titleLabel.bounds.width,
                                  height: titleLabel.bounds.height)
    }
    
}

fileprivate extension CFComposeTypeButton {
    func setupOwenView() {
        // 添加子控件
        addSubview(imageView)
        addSubview(titleLabel)
        // 配置titleLabel
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.darkGray
        titleLabel.textAlignment = .center
    }
    
}
