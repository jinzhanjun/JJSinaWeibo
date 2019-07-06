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

        
    }

    // 重写push方法，使得跟控制器不隐藏tabbar， push第二个控制器的时候会隐藏tabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if children.count > 0 {
            
//            viewController.hidesBottomBarWhenPushed = true
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor: UIColor.darkGray, highlightedColor: UIColor.orange, target: self, action: #selector(goBack))
        } else {
//            navigationItem.leftBarButtonItem = UIBarButtonItem(title: navigationItem.title ?? "", normalColor: UIColor.darkGray, highlightedColor: UIColor.orange, target: self, action: #selector(goBack))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func goBack() {
        
        navigationController?.popViewController(animated: true)
    }
}
