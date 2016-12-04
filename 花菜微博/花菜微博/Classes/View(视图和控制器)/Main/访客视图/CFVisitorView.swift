//
//  CFVisitorView.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/4.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFVisitorView: UIView {
    /// 使用字典设置访客视图的信息
    /// - Parameter dict: dict[imageName / message]
    /// 如果是首页 imageName = ""
    var visitorInfo: [String: String]? {
        didSet {
            if let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] {
                tipLabel.text = message
                if imageName != "" {
                    iconView.image = UIImage(named: imageName)
                    hoseIconView.isHidden = true
                    coverView.isHidden = true
                }
                else {
                    // 首页加动画
                    setupAnim()
                }
            }
        }
    }
    /// 注册按钮
    lazy var registerButton: UIButton = UIButton(title: "注册",
                                                             fontSize: 14,
                                                             color: UIColor.orange,
                                                             highlighterColor: UIColor.black,
                                                             backgroundImageName: "common_button_white_disable")
    /// 登录按钮
    lazy var loginButton: UIButton = UIButton(title: "登录",
                                                          fontSize: 14,
                                                          color: UIColor.darkGray,
                                                          highlighterColor: UIColor.darkGray,
                                                          backgroundImageName: "common_button_white_disable")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAnim() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        // 设置完成后不删除
        anim.isRemovedOnCompletion = false
        iconView.layer.add(anim, forKey: nil)
    }
    
    // MARK: - 私有控件
    /// 圆形视图
    fileprivate lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    /// 房子视图
    fileprivate lazy var hoseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 提示标签
    fileprivate lazy var tipLabel: UILabel = UILabel(text: "关注一些人,回这里看看有什么惊喜关注一些人,回这里看看有什么惊喜")
    /// 遮罩
    fileprivate lazy var coverView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
}

// MARK: - 设置UI界面
extension CFVisitorView {
    fileprivate func  setupSubviews() {
        backgroundColor = UIColor.cf_coler(hex: 0xededed)
        
        addSubview(iconView)
        addSubview(coverView)
        addSubview(hoseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        tipLabel.textAlignment = .center
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
        // 遮罩
        /*
        options: oc中使用0,swift使用[], 如果使用多个[.alignAllBottom |.alignAllCenterX]
        views: 视图字典 定义 VFL 中的控件名称和实际名称的映射关系
        metrics: 约束值字典, 定义控件的宽高 定义 VFL 中()指定的常数的映射关系   ()貌似可以省略
        */
        let metrics = ["margin": -35]
        let views = ["coverView": coverView, "registerButton": registerButton] as [String : Any]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[coverView]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["coverView": coverView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[coverView]-(margin)-[registerButton]",
                                                      options: [],
                                                      metrics: metrics,
                                                      views: views))
    }
}
