//
//  Array-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/5.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation


extension Array {
    
    // 将数组随机打乱
    var randomArray: Array {
        var tmp = self
        var count = tmp.count
        while (count > 0) {
             // 获取随机角标
            let index = (Int)(arc4random_uniform((UInt32)(count - 1)))
            // 获取角标对应的值
            let value = tmp[index]
            // 交换数组元素位置
            tmp[index] = tmp[count - 1]
            tmp[count - 1] = value
            count -= 1
        }
        // 返回打乱顺序之后的数组
        return tmp
    }
}
