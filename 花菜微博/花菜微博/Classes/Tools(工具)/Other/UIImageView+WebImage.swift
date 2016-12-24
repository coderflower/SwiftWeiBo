//
//  UIImageView+WebImage.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/24.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import SDWebImage


extension UIImageView {
    
    /// 隔离 SDWebImage
    ///
    /// - Parameters:
    ///   - urlString: 图片连接
    ///   - placeholderImage: 占位图
    ///   - isCircle: 是否需要切成圆形,默认为false
    func cf_setImage(urlString: String?, placeholderImage: UIImage?, isCircle: Bool = false) {
        
        guard let urlString = urlString,
            let url = URL(string: urlString)  else {
                image = placeholderImage
                return
        }
        
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self] (image, _, _, _) in
            // 判断是否需要切成圆形
            if isCircle {
                self?.image = image?.cf_resizing(size: self?.bounds.size)
            }
        }
    }
    
    
    
    
}
