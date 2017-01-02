//
//  CFRefreshView.swift
//  CFRefreshView
//
//  Created by 花菜Caiflower on 2017/1/2.
//  Copyright © 2017年 花菜Caiflower. All rights reserved.
//

import UIKit
fileprivate let CFRefreshingStateText = "正在加载数据,请稍候..."
fileprivate let CFWillRefreshingStateText = "松开即可刷新..."
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
//        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CFRefreshView {
    
    /// 添加子控件
    fileprivate func setupUI() {
        backgroundColor = UIColor.yellow
        addSubview(tipLabel)
        addSubview(tipIcon)
        addSubview(indicator)
    }
    
    fileprivate func setupConstraints() {
       
        
        
        
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
        
        
    }
}

