//
//  JJBaseViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJBaseViewController: UIViewController {
    /// 懒加载 tableView
    lazy var tableView = UITableView(frame: self.view.frame, style: .plain)
    /// 自定义导航条
    // <UINavigationBar: 0x7fb26ec1a440; frame = (0 0; 375 44); hidden = YES; opaque = NO; autoresize = W; layer = <CALayer: 0x600003805f60>>
    lazy var navBar = SecondNavgationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    lazy var navItem = UINavigationItem()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
    }
    
    // 重写 titile 方法，给自定义导航条设置标题
   override var title: String? {
        didSet {
            title = navItem.title
        }
    }
    
    // MARK: -刷新监听方法
    @objc func refresh() {
        print("刷新")
    }
    
    // 设置tableview
    private func setupTableView() {
        
        // 添加刷新控件
        let refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshController)
        
        // 取消视图的内容自动调整
        self.automaticallyAdjustsScrollViewInsets = false
        // 设置顶部下移44个点，44为navBar的高度，不包括statusBar的高度
        self.tableView.contentInset.top = 44
        
        // 设置数据源
        tableView.dataSource = self
        // 在导航栏下面插入tableView
        view.insertSubview(tableView, belowSubview: navBar)
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

// 遵守协议，实现数据源方法，只是列出方法，并不具体实现，具体实现有子类完成！
extension JJBaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 注册可重用cell
    
    // 指定返回的组
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    // 指定返回的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
