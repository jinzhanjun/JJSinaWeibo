//
//  JJMainViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJMainViewController: UITabBarController {
    
    var childList: [[String: AnyObject]]?
    // 懒加载控制器数组
    lazy var vcList = [UIViewController]()
    /// 懒加载定时器
    lazy var timer = Timer()
    // 懒加载评论按钮
    lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1、判断沙盒中是否有json
        // 获取沙盒路径
        let sandBoxUrlStr = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        var fileUrlStr = (sandBoxUrlStr as NSString).appendingPathComponent("childList.json")
        
        var data = NSData(contentsOfFile: fileUrlStr)
        
        // 判断data是否有值，如果有，就用沙盒中的data，如果没有，就从Bundle中加载
        if data == nil {
            fileUrlStr = Bundle.main.path(forResource: "childList.json", ofType: nil)!
            data = NSData(contentsOfFile: fileUrlStr)
        }
        
        // 从Bundle中加载json
        guard let childList = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
        else { return }
        
        // 遍历数组获取子控制器，添加子控制器到数组
        for i in childList {

            let vc = setChildController(dict: i)
            vcList.append(vc)
        }
        
        // 设置子控制器
        viewControllers = vcList
        
        // 添加定时器
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(unreadCount), userInfo: nil, repeats: true)
        
        //添加评论按钮
        setupComposeButton()
        // 设置界面
        setupUI()
        // 设置代理为自己
        delegate = self
        // 注册用户登录通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: JJUserSholdLoginNotification), object: nil)
    }
    
    /// 视图销毁
    deinit {
        // 销毁时钟
        timer.invalidate()
        // 注销通知
        NotificationCenter.default.removeObserver(self)
    }
    /// 通知监听方法
    @objc func userLogin(n: Notification) {
        
        let nav = UINavigationController(rootViewController: JJWebViewController())
        present(nav, animated: true, completion: nil)
        print(n)
    }
}
/// 时钟监听方法
extension JJMainViewController {
    // MARK: - 获取微博未读数量
    @objc private func unreadCount() {
        // 如果没有登录，就不加载时钟
        if !JJNetWorkManager.shared.userLogon {
            return
        }
        
        let netWork = JJNetWorkManager()
        netWork.loadUnreadCount { (unreadCount, isSuccess) in
            // 获取首页控制器
            let vc = self.children[0] as! UINavigationController
            // 设置首页控制器的tabbar 的上标
            vc.tabBarItem.badgeValue = unreadCount != 0 ? "\(unreadCount)" : nil
            
            // 设置
            UIApplication.shared.applicationIconBadgeNumber = unreadCount
        }
    }
}

// MARK: - 设置界面
extension JJMainViewController {
    private func setupComposeButton() {
        
        // 计算评论按钮的frame
        let w = tabBar.bounds.width / CGFloat(viewControllers?.count ?? 1)
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
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .selected)
        // 设置字体大小
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        // 设置根控制器的显示内容字典
        vc.dictList = dict["visitorView"] as? [String : String]
        
        let nav = JJNavigationController(rootViewController: vc)
        // 返回控制器
        return nav
    }
}

/// 实现代理方法
extension JJMainViewController: UITabBarControllerDelegate {
    
    /// 代理方法
    ///
    /// - Parameters:
    ///   - tabBarController: 当前的tabbar
    ///   - viewController: 将要显示的视图控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let idx = children.firstIndex(of: viewController)
            // 判断点击的控制器是否与将要选择的控制器一致
        if selectedIndex == 0 && idx == selectedIndex {
            // 返回到顶部
            let home = viewController.children.first as? JJHomeViewController
            home?.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            // 设置tabar角标为空
            viewController.tabBarItem.badgeValue = nil
            /// 设置应用程序角标为0
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        return !viewController.isMember(of: UIViewController.self)
    }
}
