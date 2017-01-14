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
        
        print(bounds)
    }
}


// MARK: - 设置 UI 界面
fileprivate extension CFEmoticonToolbar {
    func setupUI() {
        let helper = CFEmoticonHelper.sharedHelper
        
        for p in helper.packages {
            // 创建按钮
            let btn = UIButton(type: .custom)
            // 添加父控件
            addSubview(btn)
            // 设置标题
            btn.setTitle(p.directory, for: .normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .selected)
            btn.setTitleColor(UIColor.darkGray, for: .highlighted)
            // 设置背景图片
            // 获取图片名
            let imageName = "compose_emotion_table_\(p.bgImageName)_normal"
            let highlightImageName = "compose_emotion_table_\(p.bgImageName)_selected"
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: highlightImageName), for: .selected)
            btn.setImage(UIImage(named: highlightImageName), for: .highlighted)
        }
        
    }
}
