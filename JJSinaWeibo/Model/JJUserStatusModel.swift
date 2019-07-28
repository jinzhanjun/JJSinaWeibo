//
//  JJUserStatusModel.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/28.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

private let userAccountFile = "userAccount.json"
class JJUserStatusModel: NSObject {

    /// 网络令牌
    @objc var access_token: String?
    /// 有效时长（秒）
    @objc var expires_in: TimeInterval = 0 {
        didSet{
            expireDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    /// UID
    @objc var uid: String?
    
    /// 过期日期
    @objc var expireDate: Date?
    
    override var description: String {
        return yy_modelDescription()
    }
    /// 重写构造方法，只要一加载模型，就先从文件中获取用户账户信息
    override init() {
        super.init()
        
        // 加载用户信息
        loadUserInfo()
    }
    /// 从沙盒中读取账户信息
    private func loadUserInfo() {
        
        /// 1. 加载文件
        // 获取路径
        let sandPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        // 拼接路径
        let userAccountPathStr = (sandPath as NSString).appendingPathComponent(userAccountFile)
        
        // 从路径中读取文件
        guard let data = NSData(contentsOfFile: userAccountPathStr),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: Any?]
            else {
                return
        }
        /// 2. 使用字典设置属性值
        yy_modelSet(with: dict as [AnyHashable : Any])
        /// 3. 判断用户是否过期
        if expireDate?.compare(Date()) != .orderedDescending {
            print("账户过期！")

            // 清空 token、 uid
            access_token = nil
            uid = nil

            // 删除账户文件
            try? FileManager.default.removeItem(atPath: userAccountPathStr)
        }
    }
    
    /* 保存数据的几种类型
     1、偏好设置
     2、沙盒- 归档/plist/json
     3、数据库（FMDB/CoreData）
     4、钥匙串访问（小/ 自动加密 - 需要使用框架（SSKeychain））
    */
    /// 保存到沙盒
    func saveAccount() {
        // 0. 获取沙盒路径
        let sandPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        // 拼接路径
        let userAccountPathStr = (sandPath as NSString).appendingPathComponent(userAccountFile)
        // 1. 模型转字典
        var dict = (self.yy_modelToJSONObject() as? [String: Any?]) ?? [:]
        
        // 2. 删除 expires_in 值
        dict.removeValue(forKey: "expires_in")
        
        // 3. 字典序列化 data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        else {
                return
        }
        /// 写入沙盒
        (data as NSData).write(toFile: userAccountPathStr, atomically: true)
        
        print("保存用户账户成功 \(userAccountPathStr)")
    }
}
