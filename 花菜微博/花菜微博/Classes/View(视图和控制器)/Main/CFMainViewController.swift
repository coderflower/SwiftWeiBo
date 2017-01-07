//
//  CFMainViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import SVProgressHUD
class CFMainViewController: UITabBarController {
    static let shared: CFMainViewController = CFMainViewController()
    // 定时器
    fileprivate var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置代理
        delegate = self
        // 添加子控制器
        setupChildViewControllers()
        // 初始子UI界面
        setupOwerViews()
        
        // 初始化定时器
        setupTimer()
        // 注册登陆通知
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: kUserShoudLoginNotification),
                                               object: nil, queue: nil) { (notify) in
            print("用户点击了登录")
            var time: DispatchTime = 0
            if notify.object != nil {
                time = 2
                // 设置遮罩为渐变色
                SVProgressHUD.setDefaultMaskType(.gradient)
                // 显示蒙版
                SVProgressHUD.showInfo(withStatus: "登录超时,请重新登录")
            }
            DispatchQueue.main.asyncAfter(deadline: time, execute: { 
                let nav = UINavigationController(rootViewController: CFOAuthViewController())
                self.present(nav, animated: true, completion: nil)
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 保证composeButton在最顶部
        tabBar.bringSubview(toFront: composeButton)
    }
    deinit {
        timer?.invalidate()
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

// MARK: - UI界面相关
extension CFMainViewController {
    /// 初始化UI界面
    fileprivate func setupOwerViews() {
        // 初始化发布按钮
        setupComposeButton()
        // 初始化欢迎页
        setupNewFeatureView()
    }
    /// 初始化发布按钮
    private func setupComposeButton() {
        tabBar.backgroundImage = UIImage(named: "tabbar_background")
        // 计算每个按钮的宽度 减1是为了容差
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * width, dy: 0)
        tabBar.addSubview(composeButton)
        composeButton.addTarget(self, action: #selector(composeButtonAction), for: .touchUpInside)
    }
    /// 初始化欢迎页
    private func setupNewFeatureView() {
        // 如果更新,显示新特性,否则显示欢迎页
       let newView = isNewVersion ? CFNewFeatureView() : CFWelcomeView()
        newView.frame = view.bounds
        
        // 判断用户是否登录,如果用户没有登录,就不显示欢迎页
        if !CFNetworker.shared.userLogon && newView.isKind(of: CFWelcomeView.self) {
            print("用户没登录,且需要显示欢迎页")
            return;
        }
        view.addSubview(newView)
    }
    
    // extensions中可以有计算属性,不会占用存储空间
    /// 是否显示新特性
    fileprivate var isNewVersion: Bool {
        // 0. 获取当前版本号
        let currentVersion = Bundle.main.targetVersion
        // 1. 取之前保存的版本号
        let oldVersion = UserDefaults.standard.object(forKey: CFBoundelVersionKey) as? String
        // 2. 保存当前版本号
        UserDefaults.standard.set(currentVersion, forKey: CFBoundelVersionKey)
        // 比较版本号
        return currentVersion != oldVersion
    }
}


// MARK: - 加载子控制器
extension CFMainViewController {
    fileprivate func setupChildViewControllers() {
    
        let jsonPath = "main.json".caches

        var data = NSData(contentsOfFile: jsonPath)
        
        if data == nil {
            // 从bundle中加载
            let path = Bundle.main.path(forResource: "main", ofType: "json")
            data = NSData(contentsOfFile: path!)
        }
        
        // 反序列化json
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

// MARK: - 定时器相关
extension CFMainViewController {
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc fileprivate func updateTimer() {
        print("触发定时器")
        if !CFNetworker.shared.userLogon {
            return
        }
        CFNetworker.shared.unreadCount { (count) in
            print("检测到\(count)条新数据")
            // 设置首页tbabarItem未读微博数
            self.tabBar.items?.first?.badgeValue = count > 0 ? "\(count)" : nil
            // 设置appIcon上的数字,iOS8之后需要先获取用户授权
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

// MARK: - UITabBarControllerDelegate
extension CFMainViewController: UITabBarControllerDelegate {
    
    /// 将要选择tabbarItem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 判断当前页面是否是被选中的控制器
        if selectedViewController == viewController {
            // FIXME: 滚动到最顶部,刷新数据
            let nav = viewController as? UINavigationController
            let vc =  nav?.viewControllers.first as? CFBaseViewController
            // 滚动到顶部
            vc?.tableView?.setContentOffset(CGPoint(x: 0, y: -CFNavigationBarHeight), animated: true)
            // 刷新数据
            DispatchQueue.main.asyncAfter(deadline: 1, execute: { 
                vc?.requestData()
            })
            // 清空角标
            vc?.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
        return !(viewController.isMember(of: UIViewController.self))
    }
}


// MARK: - 发布按钮事件
extension CFMainViewController {
    @objc fileprivate func composeButtonAction() {
        print("点击了发布按钮")
        let composeView = CFComposeView.composeView()
        
        composeView.show { [weak composeView](className) in
            guard let className = className,
             let cls = NSClassFromString(className) as? UIViewController.Type else {
                composeView?.removeFromSuperview()
                return
            }
            let nav = UINavigationController(rootViewController: cls.init())
            
            self.present(nav, animated: true, completion: { 
                composeView?.removeFromSuperview()
            })
        }
    }
}
