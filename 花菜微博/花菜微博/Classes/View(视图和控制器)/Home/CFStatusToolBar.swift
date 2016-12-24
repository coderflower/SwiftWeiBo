//
//  CFStatusToolBar.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/24.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFStatusToolBar: UIView {
    var viewModel: CFStatusViewModel? {
        didSet {
            retweetButton.setTitle(viewModel?.retweetStr, for: .normal)
            commentButton.setTitle(viewModel?.commentStr, for: .normal)
            likeButton.setTitle(viewModel?.likeStr, for: .normal)
        }
    }
    
    /// 转发
    @IBOutlet weak var retweetButton: UIButton!
    /// 评论
    @IBOutlet weak var commentButton: UIButton!
    /// 点赞
    @IBOutlet weak var likeButton: UIButton!
    

}
