//
//  JJStatusModel.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/15.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit
import YYModel

class JJStatusModel: NSObject {
    
    /// Swift 4 里面继承NSObject 不再默认在变量前 添加@objc; YYModelMeta中的_keyMappedCount获取不到不带@objc的变量，所以_keyMappedCount一直是0，转出来的model 也就是 nil；
    
    /// 用户 id ，唯一识别码
    @objc var id: Int64 = 0
    /// 用户发表信息状态
    @objc var text: String?
    override var description: String {
        return yy_modelDescription()
    }
}
