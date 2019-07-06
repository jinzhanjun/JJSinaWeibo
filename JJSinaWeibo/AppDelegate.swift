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
        vc.view.backgroundColor = UIColor.cz_random()
        
        // 设置跟控制器
        window?.rootViewController = vc
        // 显示窗口
        window?.makeKeyAndVisible()
        
        
        return true
    }
}

