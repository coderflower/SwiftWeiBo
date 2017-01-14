//
//  CFPlaceholderTextView.swift
//  花菜微博
//
//  Created by 花菜 on 2017/1/13.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFPlaceholderTextView: UITextView {
    var emoticonString: String {
        // 创建可变字符串，
        var restulString = String()
        if let attr = attributedText {
            let range = NSRange(location: 0, length: attr.length)
            attr.enumerateAttributes(in: range, options: [], using: { (dict, range, _) in
                // 获取附件，并从附件中获取图片表情对应的文本
                if let attachment = dict["NSAttachment"] as? CFEmoticonAttachment,
                    let chs = attachment.chs {
                    restulString += chs
                }
                else {
                    restulString += (attr.string as NSString).substring(with: range)
                }
            })
        }
        return restulString
    }
 

    var placeholder: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    var placeholderColor = UIColor.white {
        didSet {
           setNeedsDisplay()
        }
    }
    
    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }
    override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }
    override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupUI()
        font = UIFont.systemFont(ofSize: 14)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    override func draw(_ rect: CGRect) {
        if self.hasText {
            return
        }
        
        var attrs = [String: AnyObject]()
        attrs[NSForegroundColorAttributeName] = placeholderColor
        if let font = font {
            attrs[NSFontAttributeName] = font
        }
        else {
            attrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 14)
        }
        
        let x: CGFloat = 5
        let y: CGFloat = 8
        let w: CGFloat = self.frame.size.width - 2 * x
        let h: CGFloat = self.frame.size.height - 2 * y
        let placeholderRect = CGRect(x: x, y: y, width: w, height: h)
        if let placeholder = placeholder {
            (placeholder as NSString).draw(in: placeholderRect, withAttributes: attrs)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        setNeedsDisplay()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        self.removeObserver(self, forKeyPath: "contentOffset")
    }

}


fileprivate extension CFPlaceholderTextView {
    func setupUI() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
        self.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    
    @objc func textDidChange() {
        setNeedsDisplay()
    }
}

extension CFPlaceholderTextView {
    /// 向文本视图插入表情
    ///
    /// - Parameter em: 表情模型
    func inserEmoticon(_ em: CFEmoticon?) {
        guard let em = em else {
            deleteBackward()
            return
        }
        // 插入 emoji 表情
        if let emoji = em.emoji,
            let range = selectedTextRange {
            replace(range, withText: emoji)
            return
        }
        // 插入图片表情
        // 获取表情文本
        let imageText = em.imageText(font: font!)
        // 获取 textView 属性文本,并转换为可变
        let attrM = NSMutableAttributedString(attributedString: attributedText)
        // 将图片的表情文本插入到 textView 属性文本中
        // 获取光标位置
        let range = selectedRange
        attrM.replaceCharacters(in: selectedRange, with:  imageText)
        // 重新赋值给 textView
        attributedText = attrM
        // 恢复光标位置,此处 length 不能使用 range.lengt -> 是选的字符总长 -> 可能会多选,此处应使用0
        selectedRange = NSRange(location: range.location + 1, length: 0)
        // 通知代理文本改变
        delegate?.textViewDidChange?(self)
        // 重绘占位文本
        textDidChange()
    }

}

