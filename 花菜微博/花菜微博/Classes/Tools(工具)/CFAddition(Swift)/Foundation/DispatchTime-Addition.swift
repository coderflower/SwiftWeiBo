//
//  DispatchTime-Addition.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/6.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
