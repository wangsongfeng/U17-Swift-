//
//  UIColorExtension.swift
//  U17(SWIFT)
//
//  Created by apple on 2018/2/7.
//  Copyright © 2018年 yangchao. All rights reserved.
//

import UIKit

extension UIColor {
//    根据颜色生成图片
    func imageColor() -> UIImage {
        let rect = CGRect.init(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
