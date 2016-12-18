//
//  CFOAuthViewController.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/18.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import SVProgressHUD
class CFOAuthViewController: UIViewController {

    fileprivate lazy var webview = UIWebView()
    override func loadView() {
        view = webview
        webview.delegate = self
        webview.scrollView.isScrollEnabled = false
        // 设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(closeAction))
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
    
    @objc fileprivate func closeAction() {
        SVProgressHUD.dismiss()
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
        
        if request.url?.absoluteString.hasPrefix(SinaRedirectURI) == true {
           
            // query 参数(查询)字符串
            let query = request.url?.query
            
            if query?.hasPrefix("code=") == false {
                // 用户取消授权
                closeAction()
                return false
            }
            // 获取授权码
            let code = query?.substring(from: "code=".endIndex) ?? ""
            
            print(code)
            CFNetworker.shared.requestToken(code:code) { (isSuccess) in
                if isSuccess {
                    SVProgressHUD.showError(withStatus: "网络加载失败,请稍后重试")
                } else {
                    SVProgressHUD.showInfo(withStatus: "登录成功")
                }
            }
            // 关闭页面
            closeAction()
            return false
        }
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
