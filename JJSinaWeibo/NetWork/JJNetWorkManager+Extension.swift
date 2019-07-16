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
    func loadNetWorkData(completion: @escaping (_ json: [[String: Any]]?, _ isSuccess: Bool) -> ()) {
        
        // 从网络上加载数据
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00LGIqREtNplQC4aedaec6f10ZkERu"]
        request(Method: .GET, URLString: url, parameters: params) { (json, isSuccess) in
            let result = json as? [String: Any]
            let status = result?["statuses"] as? [[String: Any]]
            // 完成回调
            completion(status, isSuccess)
        }
    }
}
