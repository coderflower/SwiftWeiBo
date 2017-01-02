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
fileprivate let CFRefreshViewHeight: CGFloat = 60
fileprivate let CFRefreshCriticalStateHeihgt: CGFloat = 100
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
                if height < 0 {
                    return
                }
                // 重新设置frame
                frame = CGRect(x: 0,
                               y: -height,
                               width: sv.bounds.width,
                               height: height)
                
                if sv.isDragging {
                    // 如果高度大于临界高度,并且刷新状态为普通状态,改变状态为可刷新
                    if height > CFRefreshCriticalStateHeihgt && (refreshView.refreshState == .Normal) {
                        print("sv.contentOffset.y")
                        // 变为将要刷新状态
                        refreshView.refreshState = .WillRefreshing
                        print("松开即可刷新")
                    }
                        // 如果是将要刷新状态并且滚动的距离小于临界高度就修改为普通状态
                    else if height < CFRefreshCriticalStateHeihgt && refreshView.refreshState == .WillRefreshing {
                        print("使劲往下拉")
                        print("sv.contentOffset.y")
                        // 修改为普通状态
                        refreshView.refreshState = .Normal
                    }
                }
                else {
                    // 放手,并且是将要刷新状态才开始刷新,否则恢复会普通状态
                    if refreshView.refreshState == .WillRefreshing {
                        print("开始准备刷新")
                        beginRefreshing()
                        // 发送刷新事件
                        sendActions(for: .valueChanged)
                    }
                }
            }
        }
    }
}

extension CFRefreshControl {
    fileprivate func setupUI() {
        backgroundColor = superview?.backgroundColor
//        clipsToBounds = true
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
                                         constant: CFRefreshViewHeight))
        
    }

}

extension CFRefreshControl {
    func beginRefreshing() {
        print("开始刷新")
        // 判断俯视图是否存在
        guard let sv = scrollView else {
            return
        }
        // 判断是否正在刷新,如果正在刷新,直接返回
        if refreshView.refreshState == .Refreshing {
            return
        }
        // 设置刷新视图的状态
        refreshView.refreshState = .Refreshing
        // 调整表格内间距
        var inset = sv.contentInset
        inset.top += CFRefreshViewHeight
        sv.contentInset = inset
        
    }
    func endRefreshing() {
        print("结束刷新")
        // 判断俯视图是否存在
        guard let sv = scrollView else {
            return
        }
        // 判断是否正在刷新,如果不是直接返回
        if refreshView.refreshState != .Refreshing {
            return
        }
        // 改变刷新控件的状态
        refreshView.refreshState = .Normal
        // 还原contentInset
        var inset = sv.contentInset
        inset.top -= CFRefreshViewHeight
        sv.contentInset = inset
    }
}
