//
//  CFStatusListViewModel.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/12/12.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import Foundation

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
                print(model.retweeted_status ?? "")
                // 添加到数组
                tmpArray.append(CFStatusViewModel(model: model))
            }
            
            print("新增 \(tmpArray.count)条数据")
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
                completion(isSuccess,true)
            }
            
        }
    }
}
