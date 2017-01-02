//
//  CFRefreshControl.swift
//  花菜微博
//
//  Created by 花菜Caiflower on 2017/1/2.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

enum CFRefreshState {
    case Normal
    case Refreshing
    case WillRefreshing
}


let CFRefreshObserverKeyContentOffset = "contentOffset"

/// 负责刷新相关的逻辑处理
class CFRefreshControl: UIControl {

    weak var scrollView: UIScrollView?
    let refreshView = CFRefreshView()
    init() {
        super.init(frame: CGRect.zero)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        // 记录父控件
        scrollView = sv
        // 添加监听
        sv.addObserver(self, forKeyPath: CFRefreshObserverKeyContentOffset, options: [], context: nil)
    }
    
    override func removeFromSuperview() {
        // 移除监听
        superview?.removeObserver(self, forKeyPath: CFRefreshObserverKeyContentOffset)
        super.removeFromSuperview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 判断是否是对应的Key
        if keyPath == CFRefreshObserverKeyContentOffset {
            if  let sv = scrollView {
                // 获取高度
                let height = -(sv.contentOffset.y + sv.contentInset.top)
                // 重新设置frame
                frame = CGRect(x: 0,
                               y: -height,
                               width: sv.bounds.width,
                               height: height)
            }
        }
    }
}

extension CFRefreshControl {
    fileprivate func setupUI() {
        backgroundColor = UIColor.red
        clipsToBounds = true
        addSubview(refreshView)
        // 添加约束
        setupConstraints()
    }

    fileprivate func setupConstraints() {
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        // X中心对齐
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        // 底部对齐
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: 0))
        // 宽度
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .width,
                                         multiplier: 1,
                                         constant: 0))
        // 高度
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1,
                                         constant: 60))
        
    }

}

extension CFRefreshControl {
    func beginRefreshing() {
        
    }
    func endRefreshing() {
        
    }
}
