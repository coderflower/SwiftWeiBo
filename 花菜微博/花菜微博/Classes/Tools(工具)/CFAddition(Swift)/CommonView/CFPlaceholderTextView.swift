//
//  CFPlaceholderTextView.swift
//  花菜微博
//
//  Created by 花菜 on 2017/1/13.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFPlaceholderTextView: UITextView {

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
            attrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 12)
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
