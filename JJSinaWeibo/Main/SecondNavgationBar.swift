//
//  SecondNavgationBar.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/7.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

/// 自定义导航条类
class SecondNavgationBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in subviews {
            
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            
            if stringFromClass.contains("BarBackground") {
                
                subview.frame = bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0, y: 20, width: UIScreen.cz_screenWidth(), height: 44)
            }
        }
        
    }

}
