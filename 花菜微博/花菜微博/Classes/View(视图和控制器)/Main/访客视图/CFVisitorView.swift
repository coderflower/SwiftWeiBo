//
//  CFVisitorView.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 私有控件
    /// 圆形视图
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    /// 房子视图
    fileprivate lazy var hoseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    fileprivate lazy var tipLabel: UILabel = UILabel(text: "关注一些人,回这里看看有什么惊喜关注一些人,回这里看看有什么惊喜")
    fileprivate lazy var registerButton: UIButton = UIButton(title: "注册",
                                                             fontSize: 14,
                                                             color: UIColor.orange,
                                                             highlighterColor: UIColor.black,
                                                             backgroundImageName: "common_button_white_disable")
    fileprivate lazy var loginButton: UIButton = UIButton(title: "登录",
                                                          fontSize: 14,
                                                          color: UIColor.darkGray,
                                                          highlighterColor: UIColor.darkGray,
                                                          backgroundImageName: "common_button_white_disable")
}


extension CFVisitorView {
    fileprivate func  setupSubviews() {
        backgroundColor = UIColor.white
        
        addSubview(iconView)
        addSubview(hoseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        // 使用苹果原生的自动布局,必须先关闭Autoresizing
        for view in subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        setupConstraints()
    }
    
    /// 添加约束
    fileprivate func setupConstraints() {
        // 设置iconView 约束
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -30))
        // 设置hoseIconView约束
        addConstraint(NSLayoutConstraint(item: hoseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: hoseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        // 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        // 限制宽度
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: NSLayoutAttribute.notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 230))
        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        // 限制宽度
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: NSLayoutAttribute.notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        // 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        // 限制宽度
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: NSLayoutAttribute.notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
    }
}
