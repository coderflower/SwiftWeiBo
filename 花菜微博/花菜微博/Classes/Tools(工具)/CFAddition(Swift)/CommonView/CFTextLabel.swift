//
//  CFTextLabel.swift
//  CFTextLable
//
//  Created by 花菜 on 2017/1/12.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit


@objc public protocol CFTextLabelDelegate: NSObjectProtocol {
    
    /// 选中链接文本
    ///
    /// - Parameters:
    ///   - textlable:  textLabel
    ///   - text:  选中的文本
    @objc optional func textLabelDidSelectedLinkText(textlable: CFTextLabel, text: String)
}

public class CFTextLabel: UILabel {
    
    /// 链接文本颜色
    public var linkTextColor = UIColor.blue
    
    /// 选中文本的背景色
    public var selectedBackgroundColor = UIColor.lightGray
    
    /// 选中文本代理
    public weak var delegate: CFTextLabelDelegate?
    // 正则匹配策略
    fileprivate let patterns = ["[a-zA-z]+://[a-zA-Z0-9/\\.]*", "#.*?#", "@[\\u4e00-\\u9fa5a-zA-Z0-9_-]*"]

    // MARK: lazy properties
    fileprivate lazy var linkRanges = [NSRange]()
    fileprivate var selectedRange: NSRange?
    fileprivate lazy var textStorage = NSTextStorage()
    fileprivate lazy var layoutManager = NSLayoutManager()
    fileprivate lazy var textContainer = NSTextContainer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareTextLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareTextLabel()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textContainer.size = bounds.size
    }
    
    fileprivate func prepareTextLabel() {
        // 关联属性
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        // 开启用户交互
        isUserInteractionEnabled = true
    }
    public override func sizeToFit() {
        super.sizeToFit()
        layoutIfNeeded()
    }

    // MARK: - override properties , 
    //一但内容变化，需要让 textStorage响应变化！
    public override var text: String? {
        didSet{
            // 重新准备文本内容
            updateTextStore()
        }
    }
    public override var attributedText: NSAttributedString? {
        didSet {
            updateTextStore()
        }
    }
    
    public override var font: UIFont! {
        didSet {
            updateTextStore()
        }
    }
    
    public override var textColor: UIColor! {
        didSet {
            updateTextStore()
        }
    }
    /// 获取字形区域
    fileprivate  func glyphsRange()-> NSRange {
        return NSRange(location: 0, length: textStorage.length)
    }
    
    fileprivate func glyphsOffset(range: NSRange) -> CGPoint {
        let rect = layoutManager.boundingRect(forGlyphRange: range, in: textContainer)
        let height = (bounds.height - rect.height) * 0.5
        
        return CGPoint(x: 0, y: height)
    }
    public override func drawText(in rect: CGRect) {
        let range = glyphsRange()
        // 获取偏移
        let offset = glyphsOffset(range: range)
        // 绘制背景
        layoutManager.drawBackground(forGlyphRange: range, at: offset)
        // 绘制字形
        layoutManager.drawGlyphs(forGlyphRange: range, at: CGPoint.zero)
    }
    // MARK: - touches 事件
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        // 获取选中的区域
        selectedRange = linkRangeAtLocation(location: location)
        // 设置富文本属性
        modifySelectedAttribute(isSet: true)
    }
    
    // 移动
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self) else {
            return
        }
        
        if let range = linkRangeAtLocation(location: location) {
            if !(range.location == selectedRange?.location && range.length == selectedRange?.length) {
                modifySelectedAttribute(isSet: false)
                selectedRange = range
                modifySelectedAttribute(isSet: true)
            }
        } else {
            modifySelectedAttribute(isSet: false)
        }
    }
    // 结束触摸
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if selectedRange != nil {
            let text = (textStorage.string as NSString).substring(with: selectedRange!)
            delegate?.textLabelDidSelectedLinkText?(textlable: self, text: text)
            
            let when = DispatchTime.now() + Double(Int64(0.25 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.modifySelectedAttribute(isSet: false)
            }
        }
    }
    // 取消
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        modifySelectedAttribute(isSet: false)
    }

    
    
}

fileprivate extension CFTextLabel {
    func linkRangeAtLocation(location: CGPoint) -> NSRange? {
        if textStorage.length == 0 {
            return nil
        }
        
        let offset = glyphsOffset(range: glyphsRange())
        let point = CGPoint(x: offset.x + location.x, y: offset.y + location.y)
        let index = layoutManager.glyphIndex(for: point, in: textContainer)
        
        for r in linkRanges {
            if index >= r.location && index <= r.location + r.length {
                return r
            }
        }
        
        return nil
    }
    
    
    /// 改变选中区域的富文本属性
    ///
    /// - Parameter isSet: 是否改变
    func modifySelectedAttribute(isSet: Bool) {
        
        guard let range = selectedRange else {
            return
        }
        
        var attributes = textStorage.attributes(at: 0, effectiveRange: nil)
        attributes[NSForegroundColorAttributeName] = linkTextColor
        if isSet {
            attributes[NSBackgroundColorAttributeName] = selectedBackgroundColor
        } else {
            attributes[NSBackgroundColorAttributeName] = UIColor.clear
            selectedRange = nil
        }
        // 添加富文本属性
        textStorage.addAttributes(attributes, range: range)
        // 重绘
        setNeedsDisplay()
    }

}

// MARK: - 更新textStorage
fileprivate extension CFTextLabel {
    fileprivate func updateTextStore() {
        guard let attributedText = attributedText else {
            return
        }
        // 设置换行模式
        let attrStringM = addLineBreakModel(attrString: attributedText)
        // 正则匹配
        regularLinkRanges(attrString: attrStringM)
        // 设置链接的富文本属性
        addLinkAttribute(attrString: attrStringM)
        // 设置文本内容
        textStorage.setAttributedString(attrStringM)
        // 重绘
        setNeedsDisplay()
    }

}

// MARK: - 设置链接富文本属性
fileprivate extension CFTextLabel {
    func addLinkAttribute(attrString: NSMutableAttributedString) {
        if attrString.length == 0 {
            return
        }
        var range = NSRange(location: 0, length: 0)
        var attributes = attrString.attributes(at: 0, effectiveRange: &range)
        attributes[NSFontAttributeName] = font
        attributes[NSForegroundColorAttributeName] = textColor
        // 添加富文本属性
        attrString.addAttributes(attributes, range: range)
        // 设置链接的文本颜色
        attributes[NSForegroundColorAttributeName] = linkTextColor
        // 遍历所有的链接数组添加属性
        for r in linkRanges {
            attrString.setAttributes(attributes, range: r)
        }
    }
}

// MARK: - 设置换行模式
fileprivate extension CFTextLabel {
    func addLineBreakModel(attrString: NSAttributedString) -> NSMutableAttributedString {
        let attrStringM = NSMutableAttributedString(attributedString: attrString)
        
        if attrStringM.length == 0 {
            return attrStringM
        }
        
        var range = NSRange(location: 0, length: 0)
        var attributes = attrStringM.attributes(at: 0, effectiveRange: &range)
        if let paragraphStyle = attributes[NSParagraphStyleAttributeName] as? NSMutableParagraphStyle {
            paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
            return attrStringM
        }
        else {
            // iOS 8.0 can not get the paragraphStyle directly
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
            attributes[NSParagraphStyleAttributeName] = paragraphStyle
            attrStringM.setAttributes(attributes, range: range)
             return attrStringM
        }
    }
}

// MARK: - 正则匹配
fileprivate extension CFTextLabel {
    /// 使用正则匹配所有的URL, #话题#， @name
    ///
    /// - Parameter attrString: 需要匹配的富文本
    func regularLinkRanges(attrString: NSAttributedString) {
        // 清空数组
        linkRanges.removeAll()
        // 获取范围
        let regxRange = NSRange(location: 0, length: attrString.string.characters.count)
        
        // 根据匹配策略创建正则表达式
        for pattern in patterns {
            guard let regx = try? NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators) else {
                continue
            }
            // 获取匹配结果
            let matches = regx.matches(in: attrString.string, options: [], range: regxRange)
            // 遍历匹配结果数组
            for m in matches {
                // 添加进数组
                linkRanges.append(m.rangeAt(0))
            }
        }
    }
    
}
    
    
    
    
