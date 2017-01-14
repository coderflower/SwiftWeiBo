//
//  CFEmoticonInputView.swift
//  CFEmoticonInputView
//
//  Created by 花菜 on 2017/1/14.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit

class CFEmoticonInputView: UIView {
    
    /// 底部工具条
    lazy var toolbar: CFEmoticonToolbar = {
        return CFEmoticonToolbar()
    }()
    /// 表情容器试图
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: CFEmoticonInputViewLayout())
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        toolbar.frame = CGRect(x: 0, y: bounds.height - 40, width: bounds.width, height: 40)
        collectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - 40)
    }
    
    
    
}


fileprivate extension CFEmoticonInputView {
    /// 初始化界面
    func setupUI()  {
        // 添加collectionView
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor.white
        // 添加 toolbar
        addSubview(toolbar)
    }
}
