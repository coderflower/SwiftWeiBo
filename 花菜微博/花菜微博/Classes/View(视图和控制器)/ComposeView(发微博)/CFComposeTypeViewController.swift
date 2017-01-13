//
//  CFComposeTypeViewController.swift
//  花菜微博
//
//  Created by 花菜Caiflower on 2017/1/7.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit
import SnapKit


class CFComposeTypeViewController: UIViewController {
    var textView = UITextView()
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
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.backgroundColor = UIColor.cf_randomColor()
        // 初始化界面
        setupUI()
        // 监听通知
        setupNotify()
    }
    
    @objc fileprivate func cancel() {
        dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

fileprivate extension CFComposeTypeViewController {
    
    /// 初始化 UI 界面
    func setupUI() {
        // 设置垂直方向永远可以拖拽
        textView.alwaysBounceVertical = true
        // 拖拽时隐藏键盘
        textView.keyboardDismissMode = .onDrag
        textView.backgroundColor = UIColor.lightGray
        textView.text = "圣诞节福利就按立方加辣椒等垃圾了就发了多少件来发掘了家里阿里积分拉丁科技拉拉解放路口见联发科技拉粉丝李会计垃圾费了尽量快点放极爱了解放路的空间啦了"
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
    }
}


// MARK: - 通知相关
fileprivate extension CFComposeTypeViewController {
    func setupNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardChangeFrame(notiy:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc func keyBoardChangeFrame(notiy: NSNotification) {
        if let rect = notiy.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
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
            // 更新约束
            view.layoutIfNeeded()
        }
        
    }
}


