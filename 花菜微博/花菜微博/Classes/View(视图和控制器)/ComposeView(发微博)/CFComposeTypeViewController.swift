//
//  CFComposeTypeViewController.swift
//  花菜微博
//
//  Created by 花菜Caiflower on 2017/1/7.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class CFComposeTypeViewController: UIViewController {
    var textView = CFPlaceholderTextView()
    var toolBar = UIToolbar()
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("发布", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .disabled)
        
        button.setBackgroundImage(UIImage(named: "common_button_orange"), for: .normal)
        button.setBackgroundImage(UIImage(named: "common_button_orange_highlighted"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .disabled)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
        button.addTarget(self, action: #selector(sendStatus), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 初始化界面
        setupUI()
        // 监听通知
        setupNotify()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
    @objc fileprivate func cancel() {
        dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func sendStatus() {
        if let text = textView.text {
            print("发微博\(text)")
            CFNetworker.shared.postStatus(text: text, completion: { (result, isSuccess) in
                let message = isSuccess ? "发布成功" : "网络不给力请稍后重试"
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.showInfo(withStatus: message)
                if isSuccess {
                    DispatchQueue.main.asyncAfter(deadline: 1) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            })
        }
    }

}

fileprivate extension CFComposeTypeViewController {
    
    /// 初始化 UI 界面
    func setupUI() {
        // 设置垂直方向永远可以拖拽
        textView.alwaysBounceVertical = true
        // 拖拽时隐藏键盘
        textView.keyboardDismissMode = .onDrag
        textView.placeholder = "分享新鲜事..."
        textView.placeholderColor = UIColor.darkGray
        textView.delegate = self
        view.addSubview(textView)
        view.addSubview(toolBar)
        setupToolBar()
        setupNavigationBar()
        setupConstraints()
        
    }
    
    /// 设置导航栏
    func setupNavigationBar() {
        // 左侧按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", target: self, action: #selector(cancel))
        // 右侧按钮
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sendButton)
        sendButton.isEnabled = false
    }
    
    /// 设置底部 toolbar
    func setupToolBar() {
        let settings = [
            ["imageName": "compose_toolbar_picture"],
            ["imageName": "compose_mentionbutton_background"],
            ["imageName": "compose_trendbutton_background"],
            ["imageName": "compose_emoticonbutton_background"],
            ["imageName": "compose_add_background"]
                        ]
        var items = [UIBarButtonItem]()
        for s in settings {
            guard let imageName = s["imageName"] else {
                continue
            }
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: imageName), for: .normal)
            button.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            button.sizeToFit()
            let barItem = UIBarButtonItem(customView: button)
            items.append(barItem)
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolBar.items = items
    }
    
    /// 设置控件约束
    func setupConstraints() {
        toolBar.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        textView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.bottom)
        }
        view.layoutIfNeeded()
    }
}


// MARK: - 通知相关
fileprivate extension CFComposeTypeViewController {
    /// 监听通知
    func setupNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardChangeFrame(notiy:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    /// 键盘位置改变通知调用方法
    @objc func keyBoardChangeFrame(notiy: NSNotification) {
        if let rect = notiy.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = notiy.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double {
            // 根据键盘位置不同，相应的修改 toolBar 的底部约束
            if rect.minY == UIScreen.main.cf_screenHeight {
                toolBar.snp.updateConstraints({ (make) in
                    make.bottom.equalToSuperview()
                })
            }
            else {
                toolBar.snp.updateConstraints({ (make) in
                    make.bottom.equalToSuperview().offset(-rect.height)
                })
            }
            UIView.animate(withDuration: duration, animations: { 
                // 更新约束
                self.view.layoutIfNeeded()
            })
        }
        
    }
}

extension CFComposeTypeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 修改发布按钮的状态
        sendButton.isEnabled = textView.hasText
    }
}

