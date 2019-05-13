//
//  UIBarButtonItem-Extension.swift
//  DYDM
//
//  Created by 梁文辉 on 2019/4/29.
//  Copyright © 2019 梁文辉. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    */
    
    // 便利构造函数
    convenience init(imageName: String , highImageName: String = "", size : CGSize = CGSize.zero) {
        let btn = UIButton()
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        btn.setImage(UIImage(named: imageName), for: .normal)
        // 创建uibutton
        self.init(customView: btn)
    }
}
