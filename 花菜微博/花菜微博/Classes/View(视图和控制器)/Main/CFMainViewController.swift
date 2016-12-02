//
//  CFMainViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFMainViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 添加子控制器
        setupChildViewControllers()
        // 初始化子控件
        setupComposeButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 保证composeButton在最顶部
        tabBar.bringSubview(toFront: composeButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 私有控件
    /// 撰写按钮
    fileprivate lazy var composeButton: UIButton = UIButton.cf_imageButton(
        "tabbar_compose_icon_add",
        backgroundImageName: "tabbar_compose_button")
    }

extension CFMainViewController {
    fileprivate func setupComposeButton() {
        tabBar.backgroundImage = UIImage(named: "tabbar_background")
        // 计算每个按钮的宽度 减1是为了容差
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count) - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        tabBar.addSubview(composeButton)
    }
    
    fileprivate func setupChildViewControllers() {
        let tmp = [
            ["clsName" : "CFHomeViewController", "title" : "首页", "imageName" : "home"],
            ["clsName" : "CFMessageViewController", "title" : "消息", "imageName" : "message_center"],
            ["clsName" : "UIViewController"],
            ["clsName" : "CFDiscoverViewController", "title" : "发现", "imageName" : "discover"],
            ["clsName" : "CFPofileViewController", "title" : "我的", "imageName" : "profile"],
        ]
        
        for i in 0..<tmp.count {
            addChildViewController(controller(dict: tmp[i]))
        }
    }

    private func controller(dict : [String : String]) -> UIViewController {
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + clsName) as? UIViewController.Type
            else {
                return UIViewController()
        }
        let vc = cls.init()
        // 设置标题
        vc.title = title
        // 设置高亮状态标题文字颜色
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.orange], for: .selected)
        // 设置图片
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        // 设置高亮图片
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        // 文字上移
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        return CFNavigationController(rootViewController: vc)
    }
}

