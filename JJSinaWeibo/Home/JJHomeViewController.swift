//
//  JJHomeViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

let cellID = "cellID"

class JJHomeViewController: JJBaseViewController {

    /// 定义网络加载数据
    lazy var dataList = [String]()
    /// 定义视图模型
    lazy var viewModel = JJStatusViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载数据
        loadData()
    }

    // 模拟延迟加载数据
    override func loadData() {
        
        // 异步加载数据
        self.viewModel.statusModel(isPullup: ispullUp) { (isSuccess) in
                if isSuccess {
                    print("字典转模型成功")
                    self.tableView?.reloadData()
                }else {
                    print("字典转模型失败")
                }
                // 结束刷新控件
                self.refreshController?.endRefreshing()
        }
        // 恢复上拉刷新标记
        self.ispullUp = false
    }
    
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏左侧按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", normalColor: UIColor.darkGray, highlightedColor: UIColor.orange, target: self, action: #selector(pushFriends))
        
        // 注册可重用cell
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
    
    // 注册可重用cell
    // 实现数据源方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取可重用cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        // 设置cell
        cell.textLabel?.text = viewModel.modelArray[indexPath.row].text
        // 返回cell
        return cell
    }
}

// 定义监听方法
extension JJHomeViewController {
    
    // 添加@objc作用： 得益于 Swift 的静态语言特性，每个函数的调用在编译期间就可以确定。因此在编译完成后可以检测出没有被调用到的 swift 函数，优化删除后可以减小最后二进制文件的大小。这个功能在 XCode 9 和 Swift 4 中终于被引进。
    // 那么为什么 OC 做不到这点呢？因为在 OC 中调用函数是在运行时通过发送消息调用的。所以在编译期并不确定这个函数是否被调用到。因为这点在混合项目中引发了另外一个问题：swift 函数怎么知道是否被 OC 调用了呢？出于安全起见，只能保留所有可能会被 OC 调用的 swift 函数（标记为 @objc 的）。
    @objc private func pushFriends() {
        
        let vc = JJDemoViewController()
        // 当push时隐藏底部tabbar
//        vc.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
