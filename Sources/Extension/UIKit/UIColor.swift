//
//  Ex_UIColor.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension HMNameSpace where Base: UIColor {
    // MARK: - 随机生成一种颜色

    /// 随机生成一种颜色
    static func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)) / 255.0,
                       green: CGFloat(arc4random_uniform(256)) / 255.0,
                       blue: CGFloat(arc4random_uniform(256)) / 255.0,
                       alpha: 1.0)
    }

    // MARK: - 将颜色转换成图片

    /// 将颜色转换成图片
    func toImage() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(base.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: - 获取颜色的hex

    /// 获取颜色的hex
    func toHexStr() -> String {
        guard let rgbComps = base.cgColor.components else {
            return "#ffffff"
        }
        var rHex = "00"
        var gHex = "00"
        var bHex = "00"
        let rgbHex = rgbComps.compactMap { Int($0 * 255) }
        if rgbComps.count > 0 {
            rHex = String(format: "%02x", rgbHex[0])
        }
        if rgbComps.count == 2 {
            gHex = String(format: "%02x", rgbHex[0])
        } else {
            gHex = String(format: "%02x", rgbHex[1])
        }
        if rgbComps.count == 2 {
            bHex = String(format: "%02x", rgbHex[0])
        } else {
            bHex = String(format: "%02x", rgbHex[2])
        }
        return "#\(rHex)\(gHex)\(bHex)"
    }
}

// MARK: - 初始化方法

public extension UIColor {
    /// 初始化 RGB(0~255)
    /// - Parameters:
    ///   - r: R 0~255
    ///   - g: G 0~255
    ///   - b: B 0~255
    ///   - a: A 透明度
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: b / 255.0, blue: a / 255.0, alpha: a)
    }

    /// hex初始化
    /// - Parameter hex: 颜色hex   #FFFFFF
    convenience init(hex: String) {
        self.init(hex: hex, alpha: 1)
    }

    /// 初始化 RGB十六进制字符串
    /// - Parameters:
    ///   - hex: 颜色hex   #FFFFFF
    ///   - alpha: 透明度 0~1
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.hm.subString(start: 1, length: hex.count - 1)
        }
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        var r: UInt32 = 255, g: UInt32 = 255, b: UInt32 = 255
        switch hexWithoutSymbol.count {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xF0 | (hexInt >> 8) & 0x0F)
            g = ((hexInt >> 0) & 0xF0 | (hexInt >> 4) & 0x0F)
            b = ((hexInt << 4) & 0xF0 | hexInt & 0x0F)
            break
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xFF
            g = (hexInt >> 8) & 0xFF
            b = hexInt & 0xFF
            break
        default:
            break
        }
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255,
            alpha: alpha)
    }
}
