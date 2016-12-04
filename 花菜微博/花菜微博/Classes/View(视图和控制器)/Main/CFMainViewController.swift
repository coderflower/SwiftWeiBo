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
    /**
     portrait  : 竖屏
     landscape : 横屏
     - 设置支持的方向之后,当前的控制器及子控制器都会遵守这个方向
     - 如果播放视频,通常是通过model展现的
    */
    /// 使用代码控制设置的方向,可以在需要的时候需要横屏的时候,单独处理
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
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
        
        
        guard let path = Bundle.main.path(forResource: "main", ofType: "json") else {
            return
        }
        
        let data = NSData(contentsOfFile: path)
        
        guard let tmp = try? JSONSerialization.jsonObject(with: data as! Data, options: []) as! [[String : AnyObject]] else {
            return
        }
        for dict in tmp {
            addChildViewController(controller(dict: dict))
        }
    }

    private func controller(dict : [String : AnyObject]) -> UIViewController {
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + clsName) as? CFBaseViewController.Type,
            let visitorInfo = dict["visitorInfo"] as? [String : String]
            else {
                return UIViewController()
        }
        let vc = cls.init()
        // 设置标题
        vc.title = title
        // 设置游客视图信息
        vc.visitorInfo = visitorInfo
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

