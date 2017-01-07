//
//  CFRefreshView.swift
//  CFRefreshView
//
//  Created by 花菜Caiflower on 2017/1/2.
//  Copyright © 2017年 花菜Caiflower. All rights reserved.
//

import UIKit
/// 正在加载时的文字
fileprivate let CFRefreshingStateText = "正在加载中"
/// 即将刷新时的数据
fileprivate let CFWillRefreshingStateText = "松开就刷新"
/// 普通状态文字
fileprivate let CFNormalStateText = "继续使劲拉"

/// 负责刷新相关的UI界面
class CFRefreshView: UIView {
    /// 提示label
    lazy var tipLabel: UILabel? = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.text = CFNormalStateText
        return label
    }()
    /// 提示图标
    var tipIcon: UIImageView? = {
        let image = UIImage(named: "tableview_pull_refresh")
        let icon = UIImageView(image: image)
        return icon
    }()
    /// 指示器
    var indicator: UIActivityIndicatorView? = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        return indicator
    }()
    var timeLabel: UILabel? = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        return label
    }()
    /// 最后刷新时间
    var lastUpdateTime: Date {
        guard let lastUpdateTime = UserDefaults.standard.object(forKey: "CFRefreshLastUpdateTimeKey") as? Date else {
            return Date()
        }
        return lastUpdateTime
    }
    
    var fmt: DateFormatter = {
        let fmt = DateFormatter()
        fmt.dateFormat = "HH:mm"
        return fmt
    }()
    
    var lastUpdateTtimeString: String {
        let timeString = fmt.string(from: lastUpdateTime)
        return "最后更新: \(timeString)"
    }
    
    var refreshState: CFRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                indicator?.stopAnimating()
                self.tipLabel?.text = CFNormalStateText
                self.timeLabel?.text = lastUpdateTtimeString
                self.tipIcon?.isHidden = false
                UIView.animate(withDuration: 0.25, animations: { 
                    self.tipIcon?.transform = CGAffineTransform.identity
                })
            case .Refreshing:
                self.tipLabel?.text = CFRefreshingStateText
                self.indicator?.isHidden = false
                self.tipIcon?.isHidden = true
                self.indicator?.startAnimating()
                self.timeLabel?.text = lastUpdateTtimeString
                self.timeLabel?.sizeToFit()
            case .WillRefreshing:
                self.tipLabel?.text = CFWillRefreshingStateText
                self.timeLabel?.text = lastUpdateTtimeString
                UIView.animate(withDuration: 0.25, animations: {
                    self.tipIcon?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.001))
                })

            }
        }
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupOwerViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CFRefreshView {
    
    /// 初始化界面
    fileprivate func setupOwerViews() {
        backgroundColor = UIColor.yellow
        if let tipLabel = tipLabel,
            let timeLabel = timeLabel,
            let indicator = indicator,
            let tipIcon = tipIcon {
            addSubview(tipLabel)
            addSubview(tipIcon)
            addSubview(indicator)
            addSubview(timeLabel)
        }
        timeLabel?.text = lastUpdateTtimeString
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        tipLabel?.sizeToFit()
        timeLabel?.sizeToFit()
        if let tipLabel = tipLabel,
            let timeLabel = timeLabel,
            let indicator = indicator,
            let tipIcon = tipIcon {
            // 获取图片尺寸
            guard let iconSize = tipIcon.image?.size else {
                return
            }
            
            let margin: CGFloat = 10
            // 设置frame
            tipLabel.frame = CGRect(x: (bounds.width - tipLabel.bounds.width) * 0.5,
                                    y: 10,
                                    width: tipLabel.bounds.width,
                                    height: tipLabel.bounds.height)
            
            tipIcon.frame = CGRect(x: (bounds.width - timeLabel.bounds.width - margin - iconSize.width) * 0.5,
                                   y: (bounds.height - iconSize.height) * 0.5,
                                   width: iconSize.width,
                                   height: iconSize.height)
            
            timeLabel.frame = CGRect(x: tipIcon.frame.maxX,
                                     y: tipLabel.frame.maxY + margin,
                                     width: timeLabel.bounds.width,
                                     height: timeLabel.bounds.height)
            
            
            indicator.center = tipIcon.center
            
            
        }
    }
 
    
    
}

