//
//  CFHomeViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFHomeViewController: CFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func showFriends() {
        navigationController?.pushViewController(CFBaseViewController(), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - 设置UI
extension CFHomeViewController {
    // MARK: - 设置导航条
    fileprivate func setupNav() {
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
    }
    
    
}
