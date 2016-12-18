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
        webview.delegate = self
        // 设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(backAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoInputUser))
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

    @objc fileprivate func autoInputUser() {
        // 准备Js脚本
        let script = "document.getElementById('userId').value = '17687929918'; document.getElementById('passwd').value = '4593679.a';"
        // 注入js
        self.webview.stringByEvaluatingJavaScript(from: script)
    }
    
}

extension CFOAuthViewController: UIWebViewDelegate {
    
    /// webView将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: 要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: 是否加载 request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let host = request.url?.host
        if host?.contains("caiflower") == true {
            let urlString = request.url?.absoluteString
            if urlString?.contains("code") == true {
                // 授权成功
                guard let range = urlString?.range(of: "code=") else {
                    return false
                }
                let code = urlString?.substring(from: range.upperBound)
                print(code ?? "")
            }
            else {
                // 授权失败
            }
            return false
        }
        else {
            return true
        }
        
    }
}
