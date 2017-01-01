//
//  CFStatusCell.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFStatusCell: UITableViewCell {

    /// 微博视图模型
    var viewModel: CFStatusViewModel? {
        didSet {
            // 昵称
            nameLabel.text = viewModel?.status.user?.screen_name
            // 内容
            contentLabel.text = viewModel?.status.text
            // 会员图标
            memberIconView.image = viewModel?.memberIcon
            // 认证图标
            vipIconView.image = viewModel?.vipIcon
            iconView.cf_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isCircle: true)
            // 设置底部工具条
            toolBar.viewModel = viewModel
            // 设置配图视图数据
            pictureView.viewModel = viewModel
            // 设置被转发微博正文
            retweetedTextLabel?.text = viewModel?.retweetedText
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
    @IBOutlet weak var contentLabel: UILabel!
    /// 底部工具条
    @IBOutlet weak var toolBar: CFStatusToolBar!
    /// 图片视图
    @IBOutlet weak var pictureView: CFPictureView!
    /// 被转发的微博正文,原创微博没有该label
    @IBOutlet weak var retweetedTextLabel: UILabel?
    override func awakeFromNib() {
        // Initialization code
        // 开启离屏渲染
        layer.drawsAsynchronously = true
        // 栅格化
        layer.shouldRasterize = true
        // 栅格化必须指定分辨率
        layer.rasterizationScale = UIScreen.main.scale
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
