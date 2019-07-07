//
//  UIbarButtonItem+Extension.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/6.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: 设置标题
    ///   - fontsize: 设置标题字体大小
    ///   - normalColor: 设置常规颜色
    ///   - highlightedColor: 设置高亮颜色
    ///   - highlightedColor: 设置高亮颜色
    ///   - target: 设置控制器
    ///   - action: 设置监听方法
    convenience init(title: String, fontsize: CGFloat = 16, normalColor: UIColor, highlightedColor: UIColor, target: Any?, action: Selector, isBack: Bool = false) {
        
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontsize, normalColor: normalColor, highlightedColor: highlightedColor)
        btn.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: btn)
        
        if isBack {
            let normalImageNmae = "navigationbar_back_withtext"
            let hightlightedImageName = "navigationbar_back_withtext_highlighted"
            btn.setImage(UIImage(named: normalImageNmae), for: .normal)
            btn.setImage(UIImage(named: hightlightedImageName), for: .highlighted)
            btn.sizeToFit()
            
        }
    }
}
