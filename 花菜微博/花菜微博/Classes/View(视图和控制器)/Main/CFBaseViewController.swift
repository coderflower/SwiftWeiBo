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
    /// 表格控件
    var tableView : UITableView?
    // MARK: - 入口
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 添加子控制器
        configSubviews()
        // 请求数据
        requestNewData()
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
// MARK: - 供子类重写的方法
extension CFBaseViewController {
    /// 请求新数据
    func requestNewData() {
        
    }
    /// 请求下一页数据
    func requestNextPageData() {
        
    }
}

// MARK: - 设置UI界面
extension CFBaseViewController {
    func configSubviews() {
        // 设置随机背景色
        view.backgroundColor = UIColor.cf_randomColor()
        // 取消自动缩进 - 如果隐藏了导航栏,会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        // 添加导航条
        setupNavgationBar()
        // 添加表格控件
        setupTableView()
    }
    
    /// 添加tableView
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? CFTabBarHeight,
                                               right: 0)
        // 将tableView放在最底下
        view.insertSubview(tableView!, at: 0)
    }
    
    // 添加自定义的导航条
    private func setupNavgationBar() {
        // 添加自定义的导航栏
        view.addSubview(navigationBar)
        // 设置item
        navigationBar.items = [navItem]
        // 设置导航栏背景色
        navigationBar.setBackgroundImage(UIImage.cf_image(with:  UIColor.cf_coler(hex: 0xf6f6f6)), for: .default)
        
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(pushToNext))
    }
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension CFBaseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    // 基类只是准备方法,子类负责具体的实现
    // 子类的数据源方法不需要super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误
        return UITableViewCell()
    }
}
