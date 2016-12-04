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
    fileprivate lazy var statusList = [String]()
    @objc fileprivate func showFriends() {
        navigationController?.pushViewController(CFBaseViewController(), animated: true)
    }
}

// MARK: - 设置UI
extension CFHomeViewController {
    override func setupUI() {
        super.setupUI()
        
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
        for i in 0..<15 {
            // 判断是上拉加载还是下拉刷新
            if isPullUp {
                // 页码加1
                statusList.append("上拉加载第 +\(pageCount)页 + \(i.description)")
            }
            else {
                // 重置页码
                pageCount = 0
                statusList.insert(i.description, at: 0)
            }
        }
        if isPullUp {
            pageCount += 1
        }
        isPullUp = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
            self.tableView?.reloadData()
            if self.refreshControl?.isRefreshing == true {
                self.refreshControl?.endRefreshing()
            }
        })
    }
}
// MARK: - tableViewDataSource和tableViewDelegate具体实现
extension CFHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellId, for: indexPath)
        cell.textLabel?.text = statusList[indexPath.row]
        return cell
    }
    
}
