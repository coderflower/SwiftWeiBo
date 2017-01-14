//
//  CFEmoticonInputViewLayout.swift
//  CFEmoticonInputView
//
//  Created by 花菜 on 2017/1/14.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit


/// 表情键盘布局
class CFEmoticonInputViewLayout: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        // 设置尺寸
        itemSize = collectionView.bounds.size
        // 设置间距
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        // 设置滚动方向 -> 水平滚动
        scrollDirection = .horizontal
    }
    
}
