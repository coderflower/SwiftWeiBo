//
//  CFBaseViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFBaseViewController: UIViewController {
    /// 自定义的导航栏
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.cf_screenWidth, height:CFNavigationBarHeight))
    /// 自定义的导航栏的内容类目
    lazy var navItem = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configSubviews()
    }
    /// 重写title的set方法
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc fileprivate func pushToNext() {
        let vc = CFBaseViewController()
        
        
        navigationController?.pushViewController(vc, animated: true)
    }

}
// MARK: - 设置UI界面
extension CFBaseViewController {
    public func configSubviews() {
        // 设置随机背景色
        view.backgroundColor = UIColor.cf_randomColor()
        // 添加自定义的导航栏
        view.addSubview(navigationBar)
        // 设置item
        navigationBar.items = [navItem]
        // 设置导航栏背景色
        navigationBar.setBackgroundImage(UIImage.cf_image(with:  UIColor.cf_coler(hex: 0xf6f6f6)), for: .default)
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(pushToNext))
    }
}
