//
//  JJNavigationController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isHidden = true
//        print(navigationBar)
    }

    // 重写push方法，使得跟控制器不隐藏tabbar， push第二个控制器的时候会隐藏tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 子控制器栈内有控制器，就设置导航栏标题。（导航控制器的根控制器不算作子控制器）
        if children.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            // 判断控制器是否为base类型
            if let vc = viewController as? JJBaseViewController {
                
                // 如果是第一个，那么就显示”首页“，如果不是第一个就显示”返回“
                var title = viewControllers.first?.title ?? "首页"
                if children.count > 1 {
                    
                    title = "返回"
                }
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange, target: self, action: #selector(goBack), isBack: true)
            }
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    // 返回上一级控制器
    @objc private func goBack() {
        popViewController(animated: true)
    }
}
