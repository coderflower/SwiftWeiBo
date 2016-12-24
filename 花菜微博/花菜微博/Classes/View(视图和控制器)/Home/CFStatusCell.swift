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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
