//
//  CFOAuthViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/18.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFOAuthViewController: UIViewController {

    fileprivate lazy var webview = UIWebView()
    override func loadView() {
        view = webview
        // 设置导航栏
        title = "登录新浪微博"
        webview.scalesPageToFit = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(backAction))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL.init(string: CFNetworker.shared.authorizeUrlString) else {
            fatalError()
        }
        let request = URLRequest(url: url)
        
        webview.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc fileprivate func backAction() {
        dismiss(animated: true, completion: nil)
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
