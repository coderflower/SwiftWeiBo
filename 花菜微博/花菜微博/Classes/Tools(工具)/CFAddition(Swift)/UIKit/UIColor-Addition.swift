//
//  UIColor-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/1.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    class func cf_color(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return self.init(red: redValue / 255.0, green: greenValue / 255.0, blue: blueValue / 255.0, alpha: alpha)
    }
    
    
    public class func cf_coler(hex: Int32, alpha:CGFloat = 1) -> UIColor {
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0xFF00) >> 8
        let blue = hex & 0xFF
        return self.cf_color(redValue: CGFloat(red), greenValue: CGFloat(green), blueValue: CGFloat(blue), alpha: alpha)
    }
    
    public class func cf_randomColor() -> UIColor  {
        return self.cf_color(redValue: CGFloat(arc4random_uniform(256)), greenValue: CGFloat(arc4random_uniform(256)), blueValue: CGFloat(arc4random_uniform(256)), alpha: 1)
    }
    
    
}
