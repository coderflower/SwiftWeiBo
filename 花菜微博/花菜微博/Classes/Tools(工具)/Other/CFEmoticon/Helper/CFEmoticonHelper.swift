//
//  CFEmoticonHelper.swift
//  CFEmoticon
//
//  Created by 花菜Caiflower on 2017/1/8.
//  Copyright © 2017年 花菜ChrisCai. All rights reserved.
//

import UIKit

let CFEmoticonBundlePath = Bundle.main.path(forResource: "CFEmoticon.bundle", ofType: nil)
let CFEmoticonBundle = Bundle(path: CFEmoticonBundlePath!)

public class CFEmoticonHelper: NSObject {
    // 单例对象,便于表情复用
    public static let sharedHelper = CFEmoticonHelper()
    
    // 要求调用者必须使用 sharedHelper访问单例对象
    private override init() {
        super.init()
        loadEmoticonPackge()
    }
    
    /// 表情包的懒加载数组 - 第一个数组是最近表情，加载之后，表情数组为空
    public lazy var packages = [CFEmoticonPackge]()
    
}


// MARK: - 加载表情包数据
fileprivate extension CFEmoticonHelper {
    
    /// 加载所有的表情包,并存储
    func loadEmoticonPackge() {
        // 获取CFEmoticon.bundle路径
        // 根据路径加载Bundle
        // 加载plist文件
        // 从plist加载表情包数组
        guard let bundel = CFEmoticonBundle,
            let emoticonsPath = bundel.path(forResource: "emoticons.plist", ofType: nil),
            let models = NSArray(contentsOfFile: emoticonsPath) as? [[String: AnyObject]]
            else {
                return
        }
        // 设置表情包数据,字典转模型,使用+= 不需要再次给packages分配控件,直接追加数据
        packages += models.map{CFEmoticonPackge(dict: $0)}
    }
}


// MARK: - 表情符号处理
extension CFEmoticonHelper {
    
    /// 根据string在所有的表情符号中查找对应的表情模型
    ///
    /// - Parameter string: 表情符号
    /// - Returns: 如果找到返回表情模型,否则返回Nil
    public func findEmoticon(_ emoticonString: String) -> CFEmoticon? {
        // 遍历表情包数组
        for p in packages {
            // 在表情包数组中过滤emoticonString
            /*
             // 方法一 常规写法
             let result = p.emoticons.filter({ (em) -> Bool in
             return em.chs == emoticonString
             })
             */
            // 方法二 尾随闭包
            /*
             let result = p.emoticons.filter(){ (em) -> Bool in
             return em.chs == emoticonString
             }
             */
            /*
             // 方法三
             // 如果闭包中只有一句,并且是返回
             // 1. 闭包格式定义可以胜率
             // 2. 参数省略之后,使用 $0,$1..依次替代原有的参数
             let result = p.emoticons.filter(){
             return $0.chs == emoticonString
             }
             */
            
            // 方法四
            // 如果闭包中只有一句,并且是返回
            // 1. 闭包格式定义可以胜率
            // 2. 参数省略之后,使用 $0,$1..依次替代原有的参数
            // 3. return也可以省略
            let result = p.emoticons.filter(){ $0.chs == emoticonString }
            // 判断结果数组数量
            if result.count == 1 {
                return result[0]
            }
        }
        return nil
    }
}


// MARK: - 表情符号处理
extension CFEmoticonHelper {
    
    /// 将给定的字符串转换成属性文本
    ///
    /// - Parameter targetString: 需要转换的字符串
    /// - Returns: 属性文本
    public func emoticonString(targetString: String, font: UIFont) -> NSMutableAttributedString {
        // 建立正则表达式,过滤所有的表情文字
        let attriString = NSMutableAttributedString(string: targetString)
        // [] () 都是正则表达式的关键字,如果要参与匹配,需要转义
        let pattern = "\\[.*?\\]"
        
        guard let regx = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attriString
        }
        // 获取所有匹配结果
        let matchs = regx.matches(in: targetString, options: [], range: NSRange(location: 0, length: attriString.length))
        // 遍历匹配项,
        // 需要使用倒序替换,保证先替换的不影响后替换的range(位置信息)
        for m in matchs.reversed() {
            let range = m.rangeAt(0)
            let subString = (targetString as NSString).substring(with: range)
            print(subString)
            // 查找对应的表情符号
            // 使用表情符号中的属性文本,替换原有的属性文本的内容
            if let em = CFEmoticonHelper.sharedHelper.findEmoticon(subString) {
                attriString.replaceCharacters(in: range, with: em.imageText(font: font))
                print(em)
            }
        }
        // 统一设置字符串的字体，保证所有字体一致
        attriString.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0, length: attriString.length))
        return attriString
    }
    
}
