//
//  CFNavigationController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 隐藏系统的导航条
        navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /// 重写push方法
    ///
    /// - Parameters:
    ///   - viewController: 压入栈的子控制器
    ///   - animated: 是否需要动画
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 不是栈底控制器才需要隐藏
        if viewControllers.count > 0 {
            // 隐藏导航栏
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = viewController as? CFBaseViewController {
                var title : String = ""
                // 判断控制器的级数,只有一个子控制器的时候显示栈底控制的标题,其他为返回
                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                // 统一设置导航栏返回按钮
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBack: true)
            }
        }
        super.pushViewController(viewController, animated: animated)
    }
}
// MARK: - 自定义的方法
extension CFNavigationController {
    @objc fileprivate func popToParent() {
        popViewController(animated: true)
    }
}
    
