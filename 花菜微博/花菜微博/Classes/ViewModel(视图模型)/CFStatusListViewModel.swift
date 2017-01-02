//
//  CFStatusListViewModel.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation
import SDWebImage
private let maxPullupTryTimes = 3
/// 尾部数据列表属兔
/*
    父类的选择
  - 如果类需要使用 'KVC' 或者字典转模型框架设置对象值,类就需要继承自NSObject
  - 如果类只是包装一些代码逻辑(写了一些函数),可以不用任何父类,好处:更加清凉级
 */
/// 负责微博的数据处理
class CFStatusListViewModel {
    /// 微博视图模型数组
    lazy var statusList = [CFStatusViewModel]()
    /// 上拉刷新错误次数
    fileprivate var pullupErrorTimes = 0
    
    /// 加载微博数据
    ///
    /// - Parameters:
    ///   - isPullup: 是否是上拉刷新
    ///   - completion: 完成回调 [请求结果,是否刷新]
    func loadStatus(isPullup: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        
        // 判断是否是上拉刷新,同时检查刷新错误次数
        if isPullup && pullupErrorTimes > maxPullupTryTimes {
            // 请求错误,不刷新
            completion(false, false)
        }
        // 如果是上拉刷新那么since_id = 0,否则为就是数组第一条微博的id
        let since_id = isPullup ? 0 : (statusList.first?.status.id ?? 0)
        // 上拉刷新,最后一条数据的id否则为0
        let max_id = !isPullup ? 0 : (statusList.last?.status.id ?? 0)
        CFNetworker.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 网络失败处理
            if !isSuccess {
                completion(false, false)
                return
            }
            // 创建视图模型数组
            var tmpArray = [CFStatusViewModel]()
            
            for dict in list ?? []{
                // 字典转模型
                guard let model = CFStatus.yy_model(with: dict) else {
                    continue
                }
                //print(model.retweeted_status ?? "")
                // 添加到数组
                tmpArray.append(CFStatusViewModel(model: model))
            }
            
           // print("新增 \(tmpArray.count)条数据")
            // 拼接数据
            if isPullup {
                self.statusList += tmpArray
            }
            else {
                self.statusList = tmpArray + self.statusList
            }
            
            if isPullup && tmpArray.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess,false)
            }
            else {
                // 缓存单张图片,在回调
                self.cacheSingleImage(list: tmpArray, finished: completion)
            }
            
        }
    }
    
    /// 缓存单张图像
    ///
    /// - Parameters:
    ///   - list: 本次请求的视图数组
    ///   - finished: 完成回调
    fileprivate func cacheSingleImage(list: [CFStatusViewModel], finished: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) -> ()) {
        // 创建队列组
        let group = DispatchGroup()
        // 记录数据长度
        var length = 0
        
        for vm in list {
            if vm.picUrls?.count != 1 {
                // 非单张跳过
                continue
            }
            // 获取图片链接
            guard let pic = vm.picUrls?[0].thumbnail_pic,
                let url = URL(string: pic) else {
                continue
            }
            print("缓存的单张图片连接为\(url)")
            // 进入队列组
            group.enter()
            // 下载图片
            // 图像下载完成之后会自动保存在沙盒中,文件名是url的md5
            // 如果沙盒中已经存在缓存的图像,后续使用SD会通过url加载图像,都会加载本地沙盒的图像
            // 不会发起网络请求,同时,回调方法,同样会调用
            SDWebImageManager.shared().downloadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _) in
                // 将图像转二进制
                if let image = image,
                    let data = UIImagePNGRepresentation(image) {
                    length += data.count
                    // 图像缓存成功更新配图视图大小
                    vm.updatePictureViewSize(image: image)
                }
                // 退出队列组
                group.leave()
            })
        }
        // 监听队列组任务完成,并在主线程回调
        group.notify(queue: DispatchQueue.main) { 
            //print("图片缓存完成\(length / 1024)K")
            finished(true, true)
        }
    }
}
