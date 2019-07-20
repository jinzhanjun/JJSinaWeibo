//
//  JJNetWorkManager.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/13.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit
import AFNetworking

/// swift 中枚举支持任意类型
/// OC中 switch/enum 只支持数据类型
/// 定义请求方式
enum WBHTTPMethod {
    case GET
    case POST
}

/// 网络管理工具
class JJNetWorkManager: AFHTTPSessionManager {
    /// 静态区/常量/ 闭包
    /// 在第一次访问时，执行闭包，并且将结果保存在 shared 常量中
    static let shared = JJNetWorkManager()
    
    /// 访问令牌
    var accessToken: String? //= "2.00LGIqREtNplQC4aedaec6f10ZkERu"
    /// 根据token判断用户是否登录
    var userLogon: Bool {
        return accessToken != nil
    }
    // 通过访问令牌获取网络数据
    func tokenRequest(token: String?, completion: @escaping (_ json: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        if token == nil {
            print("没有token！")
            return
        }
        let url = "https://api.weibo.com/2/statuses/home_timeline.json"
        var params = [String: String]()
        params["access_token"] = token
        request(Method: .GET, URLString: url, parameters: params) { (json, isSuccess) in
            let result = json as? [String: AnyObject]
            let status = result?["statuses"] as? [[String: AnyObject]]
            // 完成回调
            completion(status, isSuccess)
        }
    }

    /// 封装 GET/POST 请求
    ///
    /// - Parameters:
    ///   - Method: 请求方式GET、POST
    ///   - URLString: url
    ///   - parameters: 请求参数[String: Any]
    ///   - completion: 完成回调 json 、 isSuccess
    func request(Method: WBHTTPMethod = .GET, URLString: String, parameters: [String: Any], completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        let success = { (task: URLSessionDataTask, result: Any?) -> () in
            completion(result, true)
        }
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            
            if (task?.response as? HTTPURLResponse)?.statusCode  == 403 {
               print("token过期了")
            }
            
            completion(nil, false)
            print("网络请求失败 \(error)")
        }
        if Method == .GET {
            // GET请求方法
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            // POST 请求方法
          post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
