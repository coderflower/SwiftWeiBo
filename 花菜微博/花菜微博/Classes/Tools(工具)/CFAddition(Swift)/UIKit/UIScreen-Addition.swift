//
//  UIScreen-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

extension UIScreen {
    
    public var cf_screenWidth: CGFloat {
        return bounds.size.width
    }
    public var cf_screenHeight: CGFloat {
        return bounds.size.height
    }
    public var cf_scale: CGFloat {
        return scale
    }
}
