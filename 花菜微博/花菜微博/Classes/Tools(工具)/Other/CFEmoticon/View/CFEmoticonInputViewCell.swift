//
//  CFEmoticonInputViewCell.swift
//  CFEmoticonInputView
//
//  Created by 花菜 on 2017/1/14.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit


/// 表情键盘 cell,每个 cell 包含20个表情 + 一个删除按钮
class CFEmoticonInputViewCell: UICollectionViewCell {
    var emoticons: [CFEmoticon]? {
        didSet {
            print(emoticons?.count ?? "")
            // 隐藏所有的按钮
            for v in contentView.subviews {
                v.isHidden = true
            }
            
            // 遍历表情模型数组，设置按钮图片
            for (i,em) in (emoticons ?? []).enumerated() {
                // 取出对应的按钮
                if let btn = contentView.subviews[i] as? UIButton {
                    // 设置两个避免重复利用问题
                    btn.setImage(em.image, for: .normal)
                    btn.setTitle(em.emoji, for: .normal)
                    btn.isHidden = false
                    print(em.emoji ?? "emoji")
                }
            }
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


fileprivate extension CFEmoticonInputViewCell {
    /// 初始化界面
    func setupUI() {
        // 行，列
        let colCount = 7
        let rowCount = 3
        // 左右间距
        let margin: CGFloat = 8
        // 底部间距，用于 pageControl
        let bottomMargin: CGFloat = 16
        
        let w = (bounds.width - 2 * margin) / CGFloat(colCount)
        let h = (bounds.height - bottomMargin) / CGFloat(rowCount)
        
        // 创建21个按钮
        for i in 0..<21 {
            let btn = UIButton(type: .custom)
            contentView.addSubview(btn)
            let row = i / colCount
            let col = i % colCount
            let x = margin + CGFloat(col) * w
            let y = CGFloat(row) * h
            btn.frame = CGRect(x: x, y: y, width: w, height: h)
            // 设置按钮字体大小，
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
            btn.setTitle("\(i)", for: .normal)
            btn.tag = i
            btn.addTarget(self, action: #selector(selectedEmoticon(buttn:)), for: .touchUpInside)
        }
    }
}

extension CFEmoticonInputViewCell {
    @objc fileprivate func selectedEmoticon(buttn: UIButton) {
        print("选中第\(buttn.tag)按钮")
    }
}
