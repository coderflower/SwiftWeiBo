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
    /// 微博模型数组
    lazy var statusList = [CFStatus]()
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
        // since_id,取出数组中第一条微博的id
        let since_id = isPullup ? 0 : (statusList.first?.id ?? 0)
        // 上拉刷新,最后一条数据的id
        let max_id = !isPullup ? 0 : (statusList.last?.id ?? 0)
        CFNetworker.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            // 字典转模型
            guard let array = NSArray.yy_modelArray(with: CFStatus.self, json: list ?? []) as? [CFStatus] else {
                completion(isSuccess,false)
                return
            }
            print("新增 \(array.count)条数据")
            // FIXME: 拼接数据
            if isPullup {
                self.statusList += array
            }
            else {
                self.statusList = array + self.statusList
            }
            
            if isPullup && array.count == 0 {
                self.pullupErrorTimes += 1
                completion(isSuccess,false)
            }
            else {
                completion(isSuccess,true)
            }
            
        }
    }
}
