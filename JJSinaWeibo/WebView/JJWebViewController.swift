//
//  JJWebViewController.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/20.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class JJWebViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    private lazy var userStatusModel = JJUserStatusModel()
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", normalColor: UIColor.orange, highlightedColor: UIColor.orange, target: self, action: #selector(back))
        view = webView
        // 设置代理
        webView.delegate = self
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
/// 设置代理
extension JJWebViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
//        let request = request
        print("requet = \(request)")
        // 如果不包含baidu.com，那么就加载。
        if request.url?.absoluteString.hasPrefix(redirect_uri) == false {
            return true
        }
        // 如果不包含code，那么就取消加载数据
        if request.url?.query?.hasPrefix("code") == false {
            print("取消授权")
            return false
        }
        // 至此，request 中一定含有 code
        // 取code
        let code = request.url?.query?.suffix(from: "code=".endIndex) ?? ""
        // 获取网络令牌
        JJNetWorkManager.shared.loadUserAccount(code: String(code)) { (isSuccess) in
            
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络加载失败")
            } else {
                
                // 成功后，就发送通知，告诉接受者，登录成功。
                NotificationCenter.default.post(name: NSNotification.Name(JJUserLoginSuccessNotification), object: nil)
                self.back()
            }
        }
        return false
    }
}
