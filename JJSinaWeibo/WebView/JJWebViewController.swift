//
//  JJWebViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/20.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJWebViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor: UIColor.orange, highlightedColor: UIColor.orange, target: self, action: #selector(back))
        view = webView
        title = "登录新浪微博"
        view.backgroundColor = UIColor.white
        super.viewDidLoad()
    }
    
    @objc private func back() {
        dismiss(animated: true, completion: nil)
    }
}
