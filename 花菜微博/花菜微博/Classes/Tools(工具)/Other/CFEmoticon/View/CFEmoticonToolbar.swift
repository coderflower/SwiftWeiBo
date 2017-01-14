//
//  CFEmoticonToolbar.swift
//  CFEmoticonInputView
//
//  Created by 花菜 on 2017/1/14.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit

class CFEmoticonToolbar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 布局子控件
        let w: CGFloat = bounds.width / CGFloat(CFEmoticonHelper.sharedHelper.packages.count)
        let h: CGFloat = 40
        let rect = CGRect(x: 0, y: 0, width: w, height: h)
        for (i, btn) in subviews.enumerated() {
            btn.frame = rect.offsetBy(dx: CGFloat(i) * w, dy: 0)
        }
    }
}


// MARK: - 设置 UI 界面
fileprivate extension CFEmoticonToolbar {
    
    /// 添加子控件
    func setupUI() {
        // 遍历表情包数组，添加表情包对应的按钮
        for p in CFEmoticonHelper.sharedHelper.packages {
            // 创建按钮
            let btn = UIButton(type: .custom)
            // 添加父控件
            addSubview(btn)
            // 设置标题
            btn.setTitle(p.groupName, for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            // 设置背景图片
            // 获取图片名
            if let bgImageName = p.bgImageName {
                let imageName = "compose_emotion_table_\(bgImageName)_normal"
                let highlightImageName = "compose_emotion_table_\(bgImageName)_selected"
                if var image = UIImage(named: imageName, in: CFEmoticonBundle, compatibleWith: nil),
                    var highlightImage = UIImage(named: highlightImageName, in: CFEmoticonBundle, compatibleWith: nil) {
                    let insets = UIEdgeInsets(top: image.size.height * 0.5, left: image.size.width * 0.5, bottom: image.size.height * 0.5, right: image.size.width * 0.5)
                    // 拉伸图片
                    image = image.resizableImage(withCapInsets: insets)
                    highlightImage = highlightImage.resizableImage(withCapInsets: insets)
                    btn.setBackgroundImage(image, for: .normal)
                    btn.setBackgroundImage(highlightImage, for: .selected)
                    btn.setBackgroundImage(highlightImage, for: .highlighted)
                }
            }
        }
    }
}
