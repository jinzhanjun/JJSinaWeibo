//
//  AppDelegate.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit
import NotificationCenter

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let settings = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        // 实例化window
        window = UIWindow()
        
        // 创建视图控制器
        let vc = JJMainViewController()
        vc.view.backgroundColor = UIColor.white
        
        // 设置跟控制器
        window?.rootViewController = vc
        // 显示窗口
        window?.makeKeyAndVisible()
        loadInfoFromeWeb()
        return true
    }
}
/// 模拟网络加载访客视图数据
extension AppDelegate {
    
    // 模拟网络加载数据，并写入沙盒
    private func loadInfoFromeWeb() {
        // 异步加载网络数据
        DispatchQueue.global().async {
            // 获取url
            let url = URL(fileURLWithPath: "Users/jinzhanjun/Desktop/childList2.json")
            // 获取data
            guard let data = try? Data(contentsOf: url, options: []) else { return }
            // 获取沙盒路径字符串
            let sandBoxUrl = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            // 拼接文件路径字符串
            let filePath = (sandBoxUrl as NSString).appendingPathComponent("childList.json")
            // 获取沙盒中文件的路径
            let sandUrl = URL(fileURLWithPath: filePath)
            // 写入沙盒
            try? data.write(to: sandUrl)
        }
    }
}

extension AppDelegate {
    private func getQuanXian() {
//        usernotification
    }
}

