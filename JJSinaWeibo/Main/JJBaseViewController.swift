//
//  JJBaseViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJBaseViewController: UIViewController {
    
    /// 自定义导航条
    // <UINavigationBar: 0x7fb26ec1a440; frame = (0 0; 375 44); hidden = YES; opaque = NO; autoresize = W; layer = <CALayer: 0x600003805f60>>
    lazy var navBar = SecondNavgationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // 重写 titile 方法，给自定义导航条设置标题
   override var title: String? {
        didSet {
            title = navItem.title
        }
    }
    
    // 设置界面
    private func setupTableView() {
        
    }

    // 设置导航栏
    func setupNavigationBar() {
        // 给自定义导航条添加导航条目
        navBar.items = [navItem]
        // 设置导航条透明时的背景颜色
        navBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        // 设置导航条的Items透明时的背景颜色
        navBar.tintColor = UIColor.orange
        // 设置导航条标题的字体
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        // 添加自定义导航条
        view.addSubview(navBar)
    }
}
