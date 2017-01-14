//
//  CFEmoticonPackge.swift
//  CFEmoticon
//
//  Created by 花菜Caiflower on 2017/1/8.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

/// 表情包模型
public class CFEmoticonPackge: NSObject {
    /// 背景图片名
    public var bgImageName: String?
    /// 表情包分组名
    public var groupName: String?
    /// 表情包文件目录名
    public var directory: String? {
        didSet {
            // 从指定文件目录加载info.plist
            guard let directory = directory,
                let infoPath = CFEmoticonBundle.path(forResource: directory, ofType: "plist", inDirectory: directory),
                let array = NSArray(contentsOfFile: infoPath) as? [[String: AnyObject]]
                else {
                    return
            }
            // 字典转模型
            let tmp = array.map{CFEmoticon(dict: $0)}
            // 遍历,设置表情包目录
            for e in tmp {
                e.directory = directory
            }
            // 添加到数组
            emoticons += tmp
        }
    }
    
    /// 懒加载碧青模型的空数组
    public lazy var emoticons = [CFEmoticon]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        // KVC字典转模型
        setValuesForKeys(dict)
    }
    
    override public func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
