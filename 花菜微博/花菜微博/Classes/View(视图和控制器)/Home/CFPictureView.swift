//
//  CFPictureView.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/25.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

class CFPictureView: UIView {

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension CFPictureView {
    fileprivate func setupUI() {
        clipsToBounds = true
        let count = 3
        let rect = CGRect(x: 0, y: CFStatusPictureViewOutterMargin, width: CFStatusPictureItemWidth, height: CFStatusPictureItemWidth)
        for i in 0..<count * count {
            let iv = UIImageView()
            iv.backgroundColor = UIColor.yellow
            let row = i / 3
            let col = i % 3
            let offsetX = CGFloat(col) * (CFStatusPictureViewInnerMargin + CFStatusPictureItemWidth)
            let offsetY = CGFloat(row) * (CFStatusPictureViewInnerMargin + CFStatusPictureItemWidth)
            iv.frame = rect.offsetBy(dx: offsetX, dy: offsetY)
            addSubview(iv)
        }
        
    }
}
