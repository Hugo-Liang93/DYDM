//
//  UIColor-Extension.swift
//  DYDM
//
//  Created by 梁文辉 on 2019/4/30.
//  Copyright © 2019 梁文辉. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
