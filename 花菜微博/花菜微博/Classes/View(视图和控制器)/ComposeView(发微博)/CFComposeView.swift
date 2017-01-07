//
//  CFComposeView.swift
//  花菜微博
//
//  Created by 花菜Caiflower on 2017/1/7.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit
import pop
/// 按钮大小
fileprivate let kComposeTypeButtonSize = CGSize(width: 100, height: 100)

/// 列间距
fileprivate let composeButtonColumnMargin: CGFloat = (UIScreen.main.cf_screenWidth - 3 * kComposeTypeButtonSize.width) * 0.25
/// 行间距
fileprivate let composeButtonRowMargin: CGFloat = (224 - 2 * kComposeTypeButtonSize.width) * 0.5

class CFComposeView: UIView {

    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var scorllView: UIScrollView!
    
    @IBOutlet weak var returnButton: UIButton!
    /// 返回按钮中心点X约束
    @IBOutlet weak var returnButtonCenterXContraint: NSLayoutConstraint!
    /// 关闭按钮中心点X约束
    @IBOutlet weak var closeButtonCenterXContraint: NSLayoutConstraint!
    /// 按钮数据数组
    fileprivate let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字", "clsName": "WBComposeViewController"],
                                   ["imageName": "tabbar_compose_photo", "title": "照片/视频"],
                                   ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                                   ["imageName": "tabbar_compose_lbs", "title": "签到"],
                                   ["imageName": "tabbar_compose_review", "title": "点评"],
                                   ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                                   ["imageName": "tabbar_compose_friend", "title": "好友圈"],
                                   ["imageName": "tabbar_compose_wbcamera", "title": "微博相机"],
                                   ["imageName": "tabbar_compose_music", "title": "音乐"],
                                   ["imageName": "tabbar_compose_shooting", "title": "拍摄"]
    ]
    
    class func composeView() -> CFComposeView {
        let nib = UINib(nibName: "CFComposeView", bundle: nil)
        
        let composeView = nib.instantiate(withOwner: nil, options: nil)[0] as! CFComposeView
        
        return composeView
    }

    
    override func awakeFromNib() {
        frame = UIScreen.main.bounds
        // 初始化子视图
        setupOwerViews()
    }
    
    /// 显示发微博视图
    func show() {
        CFMainViewController.shared.view .addSubview(self)
        // 添加动画
        showCurrentView()
    }
    
    @IBAction func dismissAction() {
        
        self.removeFromSuperview()
    }
    
    
    @IBAction func returnButtonAction() {
        // 还原返回按钮和关闭按钮的位置
        returnButtonCenterXContraint.constant = 0
        closeButtonCenterXContraint.constant = 0
        scorllView.setContentOffset(CGPoint.zero, animated: true)
        UIView.animate(withDuration: 0.25, animations: { 
            self.layoutIfNeeded()
            self.returnButton.alpha = 0
        })
    }
}

fileprivate extension CFComposeView {
    func showCurrentView() {
        // 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        // 设置属性
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.5
        // 添加动画
        pop_add(anim, forKey: nil)
        // 按钮动画
        showButtons()
    }
    
    func showButtons()  {
        // 获取做动画的按钮
        let v = scorllView.subviews[0]
        
        for (i , btn) in v.subviews.enumerated() {
            // 创建弹力动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
            anim.fromValue = btn.center.y + 300
            anim.toValue = btn.center.y
            // 弹力速度
            anim.springSpeed = 8
            // 弹力系数 0 ~ 20 默认是4
            anim.springBounciness = 8
            // 动画开始时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025
            // 添加动画
            btn.layer.pop_add(anim, forKey: nil)
        }
    }
}


fileprivate extension CFComposeView {
    func setupOwerViews() {
        // 强制布局
        layoutIfNeeded()
        let rect = scorllView.bounds
        // 添加子控件
        for i in 0..<2 {
            let v = UIView()
            v.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            addButtons(view: v, index: i * 6)
            scorllView.addSubview(v)
        }
        // 配置scorllView
        scorllView.contentSize = CGSize(width: rect.width * 2, height: 0)
        scorllView.showsVerticalScrollIndicator = false
        scorllView.showsHorizontalScrollIndicator = false
        scorllView.bounces = false
        scorllView.isScrollEnabled = false
    }
    
    func addButtons(view: UIView, index: Int) {
        // 添加子控件
        // 每次添加按钮的个数
        let onceAddCount = 6
        // 每行显示的按钮个数
        let numberOfCountInColumn = 3
        
        for i in index..<index + onceAddCount {
            // 越界结束循环
            if i >= buttonsInfo.count {
                break
            }
            
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
            let title = dict["title"] else {
                continue
            }
            // 创建按钮
            let btn = CFComposeTypeButton(imageName: imageName, title: title)
            // 添加父视图
            view.addSubview(btn)
            // 添加点击事件
            if let actionName = dict["actionName"]  {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside);
            }
            else {
                btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            }
        }
        
        // 设置frame
        for (i , btn) in view.subviews.enumerated() {
            // 计算行/列
            let row = i / numberOfCountInColumn
            let col = i % 3
            // 根据行列计算x/y
            let x = CGFloat(col) * composeButtonColumnMargin + CGFloat(col) * kComposeTypeButtonSize.width
            let y: CGFloat = CGFloat(row) * (kComposeTypeButtonSize.height + composeButtonRowMargin)
            btn.frame = CGRect(origin: CGPoint(x: x, y: y), size: kComposeTypeButtonSize)
        }
        
        
    }
    
}

fileprivate extension CFComposeView {
    @objc func btnClick(btn:CFComposeTypeButton) {
        print("点击了按钮")
    }
    
    @objc func clickMore() {
        // 更新scorllView偏移量
        scorllView.setContentOffset(CGPoint(x: scorllView.bounds.width, y: 0), animated: true)
        // 更新返回按钮和关闭按钮的位置
        self.returnButtonCenterXContraint.constant -= UIScreen.main.cf_screenWidth / 6
        self.closeButtonCenterXContraint.constant += UIScreen.main.cf_screenWidth / 6
        // 添加动画效果显示返回按钮
        UIView.animate(withDuration: 0.25) { 
            self.layoutIfNeeded()
            self.returnButton.alpha = 1
        }
    }
}
