//
//  CFBaseViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFBaseViewController: UIViewController {
    /// 用户登录状态
    var userIsLogin: Bool = false
    /// 访客视图信息
    var visitorInfo: [String: String]?
    /// 自定义的导航栏
    lazy var navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.cf_screenWidth, height:CFNavigationBarHeight))
    /// 自定义的导航栏的内容类目
    lazy var navItem: UINavigationItem = UINavigationItem()
    /// 表格控件
    var tableView: UITableView?
    /// 上拉刷新控件
    var refreshControl: UIRefreshControl?
    /// 是否是上拉刷新
    var isPullUp: Bool = false
    /// 页码
    var pageCount: Int = 0
    // MARK: - 入口
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 初始化UI界面
        setupUI()
        // 请求数据
        requestData()
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
    func requestData() {
        // 如果子类不实现任何方法,默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
}

// MARK: - 设置UI界面
extension CFBaseViewController {
    /// 初始化UI界面
    func setupUI() {
        // 设置随机背景色
        view.backgroundColor = UIColor.cf_randomColor()
        // 取消自动缩进 - 如果隐藏了导航栏,会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        // 添加导航条
        setupNavgationBar()
        // 根据登录状态判断是添加表格控件还是访客视图
        userIsLogin ? setupTableView() : setupVisitorView()
        
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
    /// 添加tableView
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        // 设置内边距
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? CFTabBarHeight,
                                               right: 0)
        // 设置滚动条内边距
        tableView?.scrollIndicatorInsets = UIEdgeInsets(top: navigationBar.bounds.height,
                                                        left: 0,
                                                        bottom: tabBarController?.tabBar.bounds.height ?? CFTabBarHeight,
                                                        right: 0)
        // 将tableView放在最底下
        view.insertSubview(tableView!, belowSubview: navigationBar)
        // 添加下拉刷新控件
        setupRefreshControl()
    }
    /// 添加访客视图
    private func setupVisitorView () {
        let visitorView = CFVisitorView(frame: view.bounds)
        visitorView.visitorInfo = visitorInfo
        view.insertSubview(visitorView, belowSubview: navigationBar)
    }
    /// 添加上架刷新控件
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(requestData), for: .valueChanged)
        tableView?.addSubview(refreshControl!)
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. 判断indexPath是否是最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1;
        if row < 0 && section < 0 {
            return
        }
        // 取出最后一组的行数
        let count = tableView.numberOfRows(inSection: section)
        // 判断,如果是最后一行,同时没有在上拉刷新,就执行上拉刷新
        if row == count - 1 {
            print("上拉刷新")
            isPullUp = true
            // 执行刷新
            requestData()
        }
        
    }
    
}
