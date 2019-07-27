//
//  JJWebViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/20.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit
import WebKit

class JJWebViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor: UIColor.orange, highlightedColor: UIColor.orange, target: self, action: #selector(back))
        view = webView
        // 加载授权界面
        loadOath()
        title = "登录新浪微博"
        view.backgroundColor = UIColor.white
    }
    
    @objc private func back() {
        dismiss(animated: true, completion: nil)
    }
}

/// 加载网络数据拓展
extension JJWebViewController {
    // 加载授权界面
    private func loadOath()->() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(Appkey)&redirect_uri=\(redirect_uri)"
        let url = URL(string: urlString)
        // 加载登录界面
        webView.loadRequest(URLRequest(url: url!))
    }
}
