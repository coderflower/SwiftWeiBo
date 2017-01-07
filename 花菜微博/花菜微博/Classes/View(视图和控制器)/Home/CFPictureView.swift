//
//  CFPictureView.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/25.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFPictureView: UIView {
    var viewModel: CFStatusViewModel? {
        didSet {
            urls = viewModel?.picUrls
            calculateViewSize()
        }
    }
    
    
    fileprivate var urls: [CFStatusPicture]? {
        didSet {
            for view in subviews {
                view.isHidden = true
            }
            var index = 0
            for pictrue in urls ?? [] {
                let iv = subviews[index] as! UIImageView
                // 4张图片处理,跳过第三张不设置
                if index == 1 && urls?.count == 4 {
                    index += 1
                }
                iv.cf_setImage(urlString: pictrue.thumbnail_pic, placeholderImage: UIImage(named: "placeholder"))
                iv.isHidden = false
                index += 1
            }
        }
    }
    
    @IBOutlet fileprivate weak var heightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = superview?.backgroundColor
        setupOwerViews()
    }
}

extension CFPictureView {
    fileprivate func setupOwerViews() {
        clipsToBounds = true
        let count = 3
        let rect = CGRect(x: 0,
                          y: CFStatusPictureViewOutterMargin,
                          width: CFStatusPictureItemWidth,
                          height: CFStatusPictureItemWidth)
        
        for i in 0..<count * count {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            let row = i / 3
            let col = i % 3
            let offsetX = CGFloat(col) * (CFStatusPictureViewInnerMargin + CFStatusPictureItemWidth)
            let offsetY = CGFloat(row) * (CFStatusPictureViewInnerMargin + CFStatusPictureItemWidth)
            iv.frame = rect.offsetBy(dx: offsetX, dy: offsetY)
            iv.cf_setTapAction({ 
                print("点击了图片")
            })
            addSubview(iv)
        }
    }
}

extension CFPictureView {
    fileprivate func calculateViewSize() {
        // 宽度处理
        let v = subviews[0]
        if viewModel?.picUrls?.count == 1 {
            // 单图处理,修改subviews[0]的宽高,高度需要减去之前添加的间距
            let viewSize = viewModel?.pictureViewSize ?? CGSize.zero
            v.frame = CGRect(x: 0,
                             y: CFStatusPictureViewOutterMargin,
                             width: viewSize.width,
                             height: viewSize.height - CFStatusPictureViewOutterMargin)
        }
        else {
            // 多图处理恢复subviews[0]的宽高,保证九宫格布局的完整
            v.frame = CGRect(x: 0,
                             y: CFStatusPictureViewOutterMargin,
                             width: CFStatusPictureItemWidth,
                             height: CFStatusPictureItemWidth)
        }
        // 高度处理
        heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }
}
