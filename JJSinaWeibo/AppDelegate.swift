//
//  AppDelegate.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
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
//        // 首先判断 沙盒中是否有文件，如果没有，就从网络中加载
//        let sandBoxUrlString = getDocument()
//        sandBoxUrlString
//        
//        // 获取url
//        let url = URL(fileURLWithPath: "Users/jinzhanjun/Desktop/childList.plist")
//        
//        guard let data = try? Data(contentsOf: url, options: []) else { return }
//        // 将其写入沙盒中
//
//        print(sandBoxUrlString)
//        let sandBoxUrl = URL(fileURLWithPath: sandBoxUrlString)
//        
//        try? data.write(to: sandBoxUrl)
    }
    
    // 获取沙盒路径
    private func getDocument() -> [String] {
        // 判断沙盒中是否有访客视图数据
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last! as NSString
        
        let fileName = ["childList.json"]
        
        return path.strings(byAppendingPaths: fileName)
    }
}

