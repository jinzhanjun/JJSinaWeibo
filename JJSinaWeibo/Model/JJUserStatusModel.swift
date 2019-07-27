//
//  JJUserStatusModel.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/28.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJUserStatusModel: NSObject {

    /// 网络令牌
    @objc var access_token: String?
    /// 过期日期
    @objc var expires_in: Int64 = 0
    /// UID
    @objc var uid: Int64 = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
