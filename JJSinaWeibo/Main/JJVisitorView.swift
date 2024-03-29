//
//  JJVisitorView.swift
//  JJSinaWeibo
//
//  Created by 金占军 on 2019/7/11.
//  Copyright © 2019 金占军. All rights reserved.
//

import UIKit

class JJVisitorView: UIView {
    
    /// 懒加载注册按钮
    lazy var registBtn: UIButton = UIButton.cz_textButton(
        "注册",
        fontSize: 14,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.orange,
        backgroundImageName: "common_button_white_disable")
    /// 懒加载登录按钮
    lazy var loginBtn: UIButton = UIButton.cz_textButton(
        "登录",
        fontSize: 14,
        normalColor: UIColor.orange,
        highlightedColor: UIColor.orange,
        backgroundImageName: "common_button_white_disable")
    
    /// 访客视图信息字典 [imagename / message]， 如果为首页就什么都不设置
    var dict: [String: String]? {
        didSet {
            guard let imageName = dict?["imageName"],
                let message = dict?["message"]
                else {
                return
            }
            
            if imageName == "" {
                // 首页需要旋转
                startAnimation()
                return
            } else {
                iconView.image = UIImage(named: imageName)
                tipsView.text = message
                
                // 除了主页显示小房子和遮罩图像，其他页面不需要显示
                houseIconView.isHidden = true
                maskIconView.isHidden = true
            }
        }
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 设置动画
    private func startAnimation() {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.values = [Double.pi, -Double.pi]
        animation.duration = 8
        animation.repeatCount = MAXFLOAT
        // 防止切换页面，动画停止
        animation.isRemovedOnCompletion = false
        iconView.layer.add(animation, forKey: nil)
    }
    
    // MARK: - 私有控件
    /// 懒加载旋转图标
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    /// 懒加载遮罩图像
    private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    /// 懒加载小房子
    private lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    /// 懒加载提示文字
    private lazy var tipsView: UILabel = UILabel.cz_label(
        withText: "登录后，可以看到你喜欢的一些事情  关注一些人，在这里可",
        fontSize: 14,
        color: UIColor.darkGray)
    
    // 设置界面，添加动画
    private func setupUI() {
        
        backgroundColor = UIColor.cz_color(withRed: 237, green: 237, blue: 237)
        
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipsView)
        addSubview(registBtn)
        addSubview(loginBtn)
        
        // 文本居中
        tipsView.textAlignment = .center
        
        // 取消自动布局（autoresizing）
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        // 自动布局
        // 设置 转轮
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: -40))
        
        // 设置遮罩图像
        addConstraint(NSLayoutConstraint(
            item: maskIconView,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: maskIconView,
            attribute: .right,
            relatedBy: .equal,
            toItem: self,
            attribute: .right,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: maskIconView,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: maskIconView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .bottom,
            multiplier: 1,
            constant: 50))
        
        // 设置小房子
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: houseIconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerY,
            multiplier: 1,
            constant: 0))
        
        // 设置提示文字
        addConstraint(NSLayoutConstraint(
            item: tipsView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: tipsView,
            attribute: .top,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .bottom,
            multiplier: 1,
            constant: 0))
        addConstraint(NSLayoutConstraint(
            item: tipsView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 250))
        
        // 设置注册按钮
        addConstraint(NSLayoutConstraint(
            item: registBtn,
            attribute: .left,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .left,
            multiplier: 1,
            constant: -20))
        addConstraint(NSLayoutConstraint(
            item: registBtn,
            attribute: .top,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .bottom,
            multiplier: 1,
            constant: 40))
        addConstraint(NSLayoutConstraint(
            item: registBtn,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 80))
        // 设置登录按钮
        addConstraint(NSLayoutConstraint(
            item: loginBtn,
            attribute: .right,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .right,
            multiplier: 1,
            constant: 20))
        addConstraint(NSLayoutConstraint(
            item: loginBtn,
            attribute: .top,
            relatedBy: .equal,
            toItem: iconView,
            attribute: .bottom,
            multiplier: 1,
            constant: 40))
        addConstraint(NSLayoutConstraint(
            item: loginBtn,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 80))
    }
}
