//
//  CFRefreshView.swift
//  CFRefreshView
//
//  Created by 花菜Caiflower on 2017/1/2.
//  Copyright © 2017年 花菜Caiflower. All rights reserved.
//

import UIKit
/// 正在加载时的文字
fileprivate let CFRefreshingStateText = "正在加载数据,请稍候..."
/// 即将刷新时的数据
fileprivate let CFWillRefreshingStateText = "松开即可刷新..."
/// 普通状态文字
fileprivate let CFNormalStateText = "下拉即可刷新..."

/// 负责刷新相关的UI界面
class CFRefreshView: UIView {
    /// 提示label
    lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.text = CFNormalStateText
        label.sizeToFit()
        return label
    }()
    /// 提示图标
    var tipIcon: UIImageView = {
        let image = UIImage(named: "tableview_pull_refresh")
        let icon = UIImageView(image: image)
        return icon
    }()
    /// 指示器
    var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var refreshState: CFRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                self.indicator.isHidden = true
                self.tipLabel.text = CFNormalStateText
                self.tipIcon.isHidden = false
            case .Refreshing:
                self.tipLabel.text = CFRefreshingStateText
                self.indicator.isHidden = false
                self.tipIcon.isHidden = true
            case .WillRefreshing:
                self.tipLabel.text = CFWillRefreshingStateText
            }
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CFRefreshView {
    
    /// 初始化界面
    fileprivate func setupUI() {
        addSubview(tipLabel)
        addSubview(tipIcon)
        addSubview(indicator)
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
        // label自适应宽度
        tipLabel.sizeToFit()
        // 获取图片尺寸
        guard let iconSize = tipIcon.image?.size else {
            return
        }
        let margin: CGFloat = 10
        // 设置frame
        tipIcon.frame = CGRect(x: (self.bounds.width - tipLabel.bounds.width - margin - iconSize.width) * 0.5, y: (self.bounds.height - iconSize.height) * 0.5, width: iconSize.width, height: iconSize.height)
        
        tipLabel.frame = CGRect(x: tipIcon.frame.maxX, y: (self.bounds.height - tipLabel.bounds.height) * 0.5, width: tipLabel.bounds.width, height: tipLabel.bounds.height)
        indicator.center = tipIcon.center
        
    }
}

