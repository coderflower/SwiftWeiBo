//
//  CFStatus.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import YYModel
class CFStatus: NSObject {
    var id: Int64 = 0
    var text: String? 
    var user: CFUser?
    override var description: String {
        return yy_modelDescription()
    }
}
