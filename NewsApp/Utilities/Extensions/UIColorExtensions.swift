//
//  UIColorExtensions.swift
//  NewsApp
//
//  Created by Aibol Tungatarov on 6/16/20.
//  Copyright © 2020 Aibol Tungatarov. All rights reserved.
//

import UIKit

extension UIColor {
    
    // MARK: - Properties
    var hexString: String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let rgb = (Int)(red * 255) << 16 | (Int)(green * 255) << 8 | (Int)(blue * 255) << 0
        return String(format: "#%06x", rgb)
    }
    
    // MARK: - Inits
    convenience init(hex: String) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        guard cString.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
            return
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255, green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255, alpha: 1)
    }
    
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        guard let context = UIGraphicsGetCurrentContext() else {
            return UIImage()
        }
        self.setFill()
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
