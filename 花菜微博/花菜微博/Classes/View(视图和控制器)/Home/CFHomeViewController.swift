//
//  CFHomeViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

private let homeCellId = "CFHomeCellId"

class CFHomeViewController: CFBaseViewController {
    // MARK: - 公开属性
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 私有属性
    
    /// 列表视图模型
    fileprivate lazy var listViewModel = CFStatusListViewModel()
    
    @objc fileprivate func showFriends() {
        navigationController?.pushViewController(CFBaseViewController(), animated: true)
    }
}

// MARK: - 设置UI
extension CFHomeViewController {
    override func setupTableView() {
        super.setupTableView()
        
        setupNav()
        
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: homeCellId)
    }
    // MARK: - 设置导航条
    private func setupNav() {
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
    }
}

// MARK: - 加载数据
extension CFHomeViewController {
    override func requestData() {
        
        listViewModel.loadStatus(isPullup: self.isPullUp) { (isSuccess, shouldRefresh) in
            print("加载数据完成")
            // 恢复上拉刷新标记
            self.isPullUp = false
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            if shouldRefresh {
                // 刷新表格
                self.tableView?.reloadData()
            }
            else {
                print("没有更多数据")
            }
        }
    }
}
// MARK: - tableViewDataSource和tableViewDelegate具体实现
extension CFHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellId, for: indexPath)
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        return cell
    }
    
}
