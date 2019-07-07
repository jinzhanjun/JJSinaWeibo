//
//  Boundle+Extensions.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/7.
//  Copyright © 2019 金占军. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// 获取命名空间
    var nameSpace: String {
        
        // 获取项目名称
        return (Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? "")  + "."
    }
}
