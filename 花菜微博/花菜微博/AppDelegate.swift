//
//  AppDelegate.swift
//  花菜微博
//
//  Created by 花菜ChrisCai on 2016/11/30.
//  Copyright © 2016年 花菜ChrisCai. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 加载额外信心
        setupAddition()
        // 请求app信息
        loadAppInfo()
        // 添加窗口,设置根控制器
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CFMainViewController()
        window?.makeKeyAndVisible()

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// MARK: - 设置应用程序额外信息
extension AppDelegate {
    /// 设置应用程序额外信息
    fileprivate func setupAddition() {
        // 注册推送通知
        registerNotify()
        // 设置指示器显示时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        // 设置AFN加载数据菊花
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
    }
   fileprivate func registerNotify()  {
        if #available(iOS 10.0, *) {
            // iOS10,注册推送通知
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (isSuccess, error) in
                print("授权" + (isSuccess ? "成功" : "失败"))
            }
        }
        else {
            let settings = UIUserNotificationSettings(types: [.alert,.badge,.sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }

    }
}

// MARK: - 从服务器加载应用程序信息
extension AppDelegate {
    /// 从服务器加载应用程序信息
    fileprivate func loadAppInfo() {
        DispatchQueue.global().async {
            // 获取url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil)
            // 转data
            let data = NSData(contentsOf: url!)
            
            data?.write(toFile: "main.json".caches, atomically: true)
            
            print("应用程序信息加载完毕\("main.json".caches)")
            
        }
    }
}

