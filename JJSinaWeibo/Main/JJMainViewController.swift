//
//  JJMainViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJMainViewController: UITabBarController {
    
    // 懒加载控制器数组
    lazy var vcList = [UIViewController]()
    // 懒加载评论按钮
    lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let childList = [["clsName": "JJHomeViewController", "title": "首页", "imageName": "home"],
                         ["clsName": "JJDiscoverViewController", "title": "发现", "imageName": "discover"],
                         ["clsName": "xxx"],
                         ["clsName": "JJFriendsViewController", "title": "消息", "imageName": "message_center"],
                         ["clsName": "JJProfileViewController", "title": "我", "imageName": "profile"]
        ]
        
        // 遍历数组获取子控制器，添加子控制器到数组
        for i in childList {
            
            let vc = setChildController(dict: i)
            
            vcList.append(vc)
        }
        
        // 设置子控制器
        viewControllers = vcList
        
        //添加评论按钮
        setupComposeButton()
        // 设置界面
        setupUI()
    }
}

// MARK: - 设置界面
extension JJMainViewController {
    private func setupComposeButton() {
        
        // 计算评论按钮的frame
        let w = tabBar.bounds.width / CGFloat(viewControllers?.count ?? 1) - 1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        // 添加入tabbar
        tabBar.addSubview(composeButton)
        
    }
 
    private func setupUI() {
        
    }
    
    // MARK: - 利用反射机制，获取控制器
    private func setChildController(dict:[String: Any]) -> UIViewController {

        // 获取命名空间
        guard let clsName = dict["clsName"] as? String,
              let imageName = dict["imageName"] as? String,
              let vcCls = NSClassFromString(Bundle.main.nameSpace + clsName) as? JJBaseViewController.Type,
              let title = dict["title"] as? String
        else {
                return UIViewController()
        }

        // 实例化控制器
        let vc = vcCls.init()
        // 设置显示字体
        vc.tabBarItem.title = title
        vc.navItem.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        // 设置高亮图片，并渲染
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
//        NSAttributedString
        // 设置字体样式
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .highlighted)
        // 设置字体大小
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        
        let nav = JJNavigationController(rootViewController: vc)
        // 返回控制器
        return nav
    }
}
