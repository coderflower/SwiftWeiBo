//
//  CFComposeView.swift
//  花菜微博
//
//  Created by 花菜Caiflower on 2017/1/7.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFComposeView: UIView {

    @IBOutlet weak var closeButton: UIButton!
    
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
        setupOwerViews()
    }
    
    /// 显示发微博视图
    func show() {
        CFMainViewController.shared.view .addSubview(self)
    }
    
    @IBAction func dismissAction() {
        
        self.removeFromSuperview()
    }
}


fileprivate extension CFComposeView {
    func setupOwerViews() {
        // 强制布局
        layoutIfNeeded()
        
        
        
    }
}
