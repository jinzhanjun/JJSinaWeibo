//
//  JJDemoViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJDemoViewController: JJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        // 设置导航条标题
        navItem.title = "第" + String(navigationController?.children.count ?? 0) + "个"
        
        // 设置导航条右侧按钮
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一页", normalColor: UIColor.darkGray, highlightedColor: UIColor.orange, target: self, action: #selector(showNext))
    }
}

extension JJDemoViewController {
    @objc private func showNext() {
        // 实例化控制器
        let vc = JJDemoViewController()
    
        navigationController?.pushViewController(vc, animated: true)
    }
}
