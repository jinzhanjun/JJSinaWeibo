//
//  JJStatusViewModel.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/15.
//  Copyright © 2019 金占军. All rights reserved.
//

import Foundation
import YYModel

/// 视图模型 主要用来字典转模型，封装显示之前的数据处理逻辑
/// 封装业务逻辑，封装网络处理，封装数据缓存
/// 父类的继承：
/// 类如果使用‘KVC’或者使用框架设置字典键与值，需要继承自 NSObject
/// 如果只是封装一个代码逻辑（就是一些函数），就不需要继承任何父类
class JJStatusViewModel {
    
    lazy var model = JJStatusModel()
    lazy var modelArray = [JJStatusModel]()
    
    func statusModel(completion: @escaping (_ isSuccess: Bool)->()){
        
        JJNetWorkManager.shared.loadNetWorkData { (json, isSuccess) in
            guard let array = NSArray.yy_modelArray(with: JJStatusModel.self, json: json ?? []) as? [JJStatusModel] else {
                completion(isSuccess)
                return
            }
            
            self.modelArray += array
            completion(isSuccess)
        }
    }
}
