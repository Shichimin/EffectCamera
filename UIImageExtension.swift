//
//  UIImageExtension.swift
//  MyCamera
//
//  Created by Tomoki Kawakami on 2020/09/04.
//  Copyright © 2020 Tomoki Kawakami. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func resize() -> UIImage? {
        let rate = 1024.0 / self.size.width
        let rect = CGRect(x: 0, y: 0, width: self.size.width * rate, height: self.size.height * rate)
        
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
