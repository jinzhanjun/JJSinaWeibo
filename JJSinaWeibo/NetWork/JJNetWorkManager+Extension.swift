//
//  JJNetWorkManager+Extension.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/13.
//  Copyright © 2019 金占军. All rights reserved.
//

import Foundation

/// 新浪微博的网络请求拓展
extension JJNetWorkManager {
    /// 加载网络数据
    func loadNetWorkData(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ json: [[String: Any]]?, _ isSuccess: Bool) -> ()) {
        
        // 从网络上加载数据 , "since_id": "\(since_id)"  "max_id": "\(max_id)"
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00LGIqRErQbMrBb54b4a70a70HeoWr", "since_id": "\(since_id)", "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        request(Method: .GET, URLString: url, parameters: params) { (json, isSuccess) in
            let result = json as? [String: Any]
            let status = result?["statuses"] as? [[String: Any]]
            // 完成回调
            completion(status, isSuccess)
        }
    }
    
    /// 加载未读微博数量
    func loadUnreadCount(completion: @escaping (_ count: Int, _ isSuccess: Bool) -> ()) {
        let url = "https://rm.api.weibo.com/2/remind/unread_count.json"
        let params = ["access_token": "2.00LGIqRErQbMrBb54b4a70a70HeoWr"]
        request(URLString: url, parameters: params) { (json, isSuccess) in
            let result = json as? [String: Any]
            let count = result?["status"] as? Int
            completion(count ?? 0, isSuccess)
        }
    }
}

extension JJNetWorkManager {
    /// 获取用户访问令牌和账号数据
    func loadUserAccount(code: String, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        let tokenAccessUrl = "https://api.weibo.com/oauth2/access_token"
        let params = [
            "client_id": Appkey,
            "client_secret": AppSecret,
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": redirect_uri] as [String : Any]
        // 发起网络请求
        request(Method: .POST, URLString: tokenAccessUrl, parameters: params) { (json, isSuccess) in
            
            let json = json as? [String: Any?] ?? [:]
            
            /// 给用户数据模型赋值
            self.userAccount.yy_modelSet(withJSON: json)
            // 保存用户账户信息
            self.userAccount.saveAccount()
            // 执行闭包
            completion(isSuccess)
        }
    }
}
