//
//  CFDBHelper.swift
//  CFDBHelper
//
//  Created by 花菜 on 2017/1/16.
//  Copyright © 2017年 花菜. All rights reserved.
//

import UIKit
import FMDB


/// 数据库管理器
/**
  1. 数据库本职上是保存在沙盒中的一个文件，必须先创建并且打开数据库
     FMDB 队列，串行队列，同步执行
  2. 创建数据库表
  3. 增删改查
 */
class CFDBHelper {
    
    /// 单利，全局的数据库工具访问点
    static let sharedHelper: CFDBHelper = CFDBHelper()
    
    /// 数据库队列
    let queue: FMDatabaseQueue
    
    private init() {
        // 获取沙盒全路径
        let path = "status.db".document
        print("数据库路径 \(path)")
        // 创建数据库队列,同时创建或者打开数据库
        queue = FMDatabaseQueue(path: path)
        // 创建表格
        creatTable()
    }
}

// MARK: - 微博数据操作
extension CFDBHelper {
    /// 新增或者修改微博数据，微博数据在刷新的时候，可能会出现重叠
    ///
    /// - Parameters:
    ///   - userId: 当前登录用户的 id
    ///   - array: 从网络获取的`字典数组`
    func updateStatus(userId:String, array: [[String: AnyObject]]) {
        // 1. 准备 SQL
        /**
         statusId:  要保存的微博代号
         userId:    当前登录用户的 id
         status:    完整微博字典的 json 二进制数据
         */
        let sql = "INSERT OR REPLACE INTO T_Status (statusId, userId, status) VALUES (?, ?, ?);"
        
        // 2. 执行 SQL
        queue.inTransaction { (db, rollback) in
            
            // 遍历数组，逐条插入微博数据
            for dict in array {
                
                // 从字典获取微博代号／将字典序列化成二进制数据
                guard let statusId = dict["idstr"] as? String,
                    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
                    else {
                        continue
                }
                
                // 执行 SQL
                if db?.executeUpdate(sql, withArgumentsIn: [statusId, userId, jsonData]) == false {
                    
                    // 需要回滚 *rollback = YES;
                    // Xcode 的自动语法转换，不会处理此处！
                    // Swift 1.x & 2.x => rollback.memory = true;
                    // Swift 3.0 的写法
                    rollback?.pointee = true
                    
                    break
                }
                
                // 模拟回滚
                // rollback?.pointee = true
                // break
            }
        }
    }
    
    /// 执行一个 sql，返回字典的数组
    ///
    /// - Parameter sql:  sql
    /// - Returns: 字典数组
    func executeRecordSet(sql: String) -> [[String: AnyObject]] {
        // 查询数据不会修改数据，所以不需要开启事务
        // 事务的木的，是为了保证数据的有效性，一旦失效，回滚到初始状态
        // 定义结果数组
        var array = [[String: AnyObject]]()
        queue.inDatabase { (db) in
            guard let result = db?.executeQuery(sql, withArgumentsIn: []) else {
                return
            }
            // 循环结果集
            while result.next() {
                // 获取列数
                let colCount = result.columnCount()
                // 遍历所有列
                for col in 0..<colCount {
                    // 获取列名 key ,值 value
                    guard let name = result.columnName(for: col),
                        let value = result.object(forColumnIndex: col) else {
                            continue
                    }
                    // 追加结果
                    array.append([name: value as AnyObject])
                }
            }
            
        }
        return array
    }
    
    
    /// 从数据库加载微博数据数组
    ///
    /// - Parameters:
    ///   - userId: 当前登陆的用户账号
    ///   - since_id: 返回 ID 比 since_id 大的微博
    ///   - max_id: 返回 ID 小于 max_id 的微博
    /// - Returns: 微博的字典数组，将数据库中 status 字段对应的二进制数据反序列化，生成字典
    func loadStatus(userId: String, since_id: Int64, max_id: Int64) -> [[String: AnyObject]]  {
        
        // 准备 sql
        var sql = "SELECT statusId, userId, status FROM T_Status \n"
        sql += "WHERE userId = \(userId) \n"
        // 上拉/下拉处理
        if since_id > 0
        {
            // 下拉刷新，取出比since_id大的微博
            sql += "AND statusId > \(since_id) \n"
        }
        else if max_id > 0
        {
            // 上拉加载,取出比max_id小的微博
            sql += "AND statusId < \(max_id) \n"
        }
        
        // 按照 statusId 倒序排列，每次取20条
        sql += "ORDER BY statusId DESC LIMIT 20;"
        
        // 执行 sql
        let array = executeRecordSet(sql: sql)
        // 遍历数组，反序列化 json
        var result = [[String: AnyObject]]()
        
        for dict in array {
            guard let jsonData = dict["status"] as? Data,
            let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject ] else {
                continue 
            }
            // 追加到数组
            result.append(json ?? [:])
        }
        return result
    }
}

// MARK: - 创建数据库表，以及其他私有方法
fileprivate extension CFDBHelper {
    func creatTable()  {
        // 准备 sql , 从文件中加载 sql 语句
        guard let path = Bundle.main.path(forResource: "status.sql", ofType: nil),
            let sql = try? String(contentsOfFile: path) else {
                return
        }
        // 执行 sql - FMDB 的内部队列，串行队列，同步执行
        // 可以保证同一时间，只有一个任务操作数据库，从而保证数据库的读写安全
        queue.inDatabase { (db) in
            // 只有在创表的时候，使用执行多条语句，可以一次创建多个数据表
            // 在执行增删改的时候，一定不要使用 statements 方法，否则有可能会被注入
            if db?.executeStatements(sql) == true {
                print("创表成功")
            }
            else {
                print("创表失败")
            }
        }
        print("执行完毕")
    }
}
