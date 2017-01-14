//
//  CFEmoticonInputView.swift
//  CFEmoticonInputView
//
//  Created by 花菜 on 2017/1/14.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit

private let CFEmoticonInputViewCellId = "CFEmoticonInputViewCellId"
/// 表情键盘
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
    var selectedEmoticonCallBack: ((_ emoticon: CFEmoticon?) -> ())?
    
    class func inputView(frame: CGRect, selectedCallBack: @escaping (_ emoticon: CFEmoticon?) -> ()) -> CFEmoticonInputView {
        let inputView = CFEmoticonInputView(frame: frame)
        inputView.selectedEmoticonCallBack = selectedCallBack
        return inputView
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    internal required init?(coder aDecoder: NSCoder) {
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
        
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        collectionView.register(CFEmoticonInputViewCell.self, forCellWithReuseIdentifier: CFEmoticonInputViewCellId)
    }
}


// MARK: - UICollectionViewDataSource 数据源
extension CFEmoticonInputView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return CFEmoticonHelper.sharedHelper.packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CFEmoticonHelper.sharedHelper.packages[section].numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CFEmoticonInputViewCellId, for: indexPath) as! CFEmoticonInputViewCell

        // 取出对应的表情包
        let p = CFEmoticonHelper.sharedHelper.packages[indexPath.section]
        // 获取对应页面的表情数据
        cell.emoticons = p.emoticon(page: indexPath.row)
        // 设置代理
        cell.delegate = self
        
        return cell
    }
}


// MARK: - CFEmoticonInputViewCellDelegate 
extension CFEmoticonInputView: CFEmoticonInputViewCellDelegate {
    func emoticonInputViewCellDidSelectedEmoticon(cell: CFEmoticonInputViewCell, emoticon: CFEmoticon?) {
        // 如果emoticon 为空则点击的是删除按钮
        selectedEmoticonCallBack?(emoticon)
    }
}
