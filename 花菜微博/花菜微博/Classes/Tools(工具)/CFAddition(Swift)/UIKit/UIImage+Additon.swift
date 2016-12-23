//
//  UIImage+Additon.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/23.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

extension UIImage {
   
    
    /// 图片拉伸
    ///
    /// - Parameters:
    ///   - image: 原图片
    ///   - size: 目标大小
    /// - Returns: 新的图片
    func resizing(size: CGSize?, backColor: UIColor = UIColor.white, borderColor: UIColor = UIColor.lightGray, borderWidth: CGFloat = 1) -> UIImage? {
        // 0. 获取矩形框
        var size = size
        if size == nil {
            let width = min(self.size.width, self.size.height)
            size = CGSize(width: width, height: width)
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        // 1. 开启上下文
        /**
         参数:
         1. size: 绘图尺寸
         2. opaque: 不透明度
         3. scale: 设置为0会自动根据主屏幕的分辨率,默认使用1.0的分辨率
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        // 2. 背景填充
        backColor.setFill()
        UIRectFill(rect)
        
        // 3. 创建圆形路径
        let path = UIBezierPath(ovalIn: rect)
        // 4. 路径裁切
        path.addClip()
        
        // 5. 绘制图片
        self.draw(in: rect)
        
        // 6.绘制内切边框
        let ovalPath = UIBezierPath(ovalIn: rect)
        
        borderColor.setStroke()
        ovalPath.lineWidth = borderWidth
        ovalPath.stroke()
        
        // 7. 获取图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // 8. 关闭上下文
        UIGraphicsEndImageContext()
        // 9. 返回结果
        return newImage
    }
}
