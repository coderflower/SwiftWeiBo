//
//  CFEmoticonInputViewCell.swift
//  CFEmoticonInputView
//
//  Created by 花菜 on 2017/1/14.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit

protocol CFEmoticonInputViewCellDelegate: NSObjectProtocol {
    
    /// 选中表情回调
    ///
    /// - Parameters:
    ///   - cell:  cell
    ///   - emoticon: 对应的表情模型/nil 则表示点击的是删除按钮
    func emoticonInputViewCellDidSelectedEmoticon(cell: CFEmoticonInputViewCell, emoticon: CFEmoticon?)
}

/// 表情键盘 cell,每个 cell 是一个完整的页面 包含20个表情 + 一个删除按钮
class CFEmoticonInputViewCell: UICollectionViewCell {
    var emoticons: [CFEmoticon]? {
        didSet {
            print(emoticons?.count ?? "")
            // 隐藏所有的按钮
            for v in contentView.subviews {
                v.isHidden = true
            }
            // 显示删除按钮
            contentView.subviews.last?.isHidden = false
            
            // 遍历表情模型数组，设置按钮图片
            for (i,em) in (emoticons ?? []).enumerated() {
                // 取出对应的按钮
                if let btn = contentView.subviews[i] as? UIButton {
                    // 设置标题、图片 避免重复利用问题
                    btn.setImage(em.image, for: .normal)
                    btn.setTitle(em.emoji, for: .normal)
                    // 显示按钮
                    btn.isHidden = false
                }
            }
            
        }
    }
    
    /// 代理
    weak var delegate: CFEmoticonInputViewCellDelegate?
    
    
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
            btn.tag = i
            btn.addTarget(self, action: #selector(selectedEmoticon(button:)), for: .touchUpInside)
        }
        
        // 取出最后一个，设置图片
        let removeButton = contentView.subviews.last as! UIButton
        removeButton.setImage(UIImage(named: "compose_emotion_delete", in: CFEmoticonBundle, compatibleWith: nil), for: .normal)
        removeButton.setImage(UIImage(named: "compose_emotion_delete_highlighted", in: CFEmoticonBundle, compatibleWith: nil), for: .highlighted)
        
    }
}

extension CFEmoticonInputViewCell {
    @objc fileprivate func selectedEmoticon(button: UIButton) {
        var em: CFEmoticon?
        if button.tag < emoticons?.count ?? 0 {
            em = emoticons?[tag]
        }
        // 如果是删除按钮，则 em 为 nil
        delegate?.emoticonInputViewCellDidSelectedEmoticon(cell: self, emoticon: em)
        
    }
}
