//
//  CFStatusCell.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

/// 微博 cell 代理
@objc protocol CFStatusCellDelegate: NSObjectProtocol {
    
    /// 微博 cell选中 URL 回调
    ///
    /// - Parameters:
    ///   - cell: 微博 cell
    ///   - text: 被选中的文本
    @objc func statusCellDidSelectedLinkText(cell: CFStatusCell, text: String)
}

class CFStatusCell: UITableViewCell {
    weak var delegate: CFStatusCellDelegate?
    /// 微博视图模型
    var viewModel: CFStatusViewModel? {
        didSet {
            // 昵称
            nameLabel.text = viewModel?.status.user?.screen_name
            // 设置正文属性文本
            contentLabel.attributedText = viewModel?.statusAttrText
            // 设置转发微博属性文本
            retweetedTextLabel?.attributedText = viewModel?.retweetedAttrText
            // 会员图标
            memberIconView.image = viewModel?.memberIcon
            // 认证图标
            vipIconView.image = viewModel?.vipIcon
            iconView.cf_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isCircle: true)
            // 设置底部工具条
            toolBar.viewModel = viewModel
            // 设置配图视图数据
            pictureView.viewModel = viewModel
            // 设置微博来源
            sourceLable.text = viewModel?.status.source
        }
    }
    
    /// 头像
    @IBOutlet weak var iconView: UIImageView!
    /// 昵称
    @IBOutlet weak var nameLabel: UILabel!
    /// 会员
    @IBOutlet weak var memberIconView: UIImageView!
    /// 认证
    @IBOutlet weak var vipIconView: UIImageView!
    /// 时间
    @IBOutlet weak var timeLabel: UILabel!
    /// 来源
    @IBOutlet weak var sourceLable: UILabel!
    /// 正文
    @IBOutlet weak var contentLabel: CFTextLabel!
    /// 底部工具条
    @IBOutlet weak var toolBar: CFStatusToolBar!
    /// 图片视图
    @IBOutlet weak var pictureView: CFPictureView!
    /// 被转发的微博正文,原创微博没有该label
    @IBOutlet weak var retweetedTextLabel: CFTextLabel?
    override func awakeFromNib() {
        // Initialization code
        // 开启离屏渲染
        layer.drawsAsynchronously = true
        // 栅格化
        layer.shouldRasterize = true
        // 栅格化必须指定分辨率
        layer.rasterizationScale = UIScreen.main.scale
        // 设置代理
        contentLabel.delegate = self
        retweetedTextLabel?.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CFStatusCell: CFTextLabelDelegate {
    func textLabelDidSelectedLinkText(textlable: CFTextLabel, text: String) {
        delegate?.statusCellDidSelectedLinkText(cell: self, text: text)
    }
}
