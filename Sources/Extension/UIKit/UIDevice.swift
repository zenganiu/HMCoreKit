//
//  Ex_UIDevice.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension HMNameSpace where Base: UIDevice {
    // MARK: - 强制屏幕旋转

    /// 强制屏幕旋转
    /// - Parameter orientation: 旋转方向
    func forceRotateOrientation(orientation: UIInterfaceOrientation) {
        let value = NSNumber(value: orientation.rawValue)
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    // MARK: - 是否是iPad

    /// 设备是否是iPad
    static func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    // MARK: - 是否是iPhone

    /// 设备是否是iPhone
    static func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    // MARK: - 设备系统语言,默认为en

    /// 设备系统语言,默认为en
    /// - Returns: 系统语言
    static func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }

    // MARK: - 设备名称

    /// 设备名称
    static func deviceName() -> String {
        return UIDevice.current.name
    }

    // MARK: - 设备版本(Float)

    /// 设备版本(Float)
    static func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }

    // MARK: - 设备版本(String)

    /// 设备版本(String)
    static func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    // MARK: - 设备系统名称 (iOS)

    /// 设备系统名称 (iOS)
    /// - Returns: 名称
    static func systemName() -> String {
        return UIDevice.current.systemName
    }

    // MARK: - UUID

    /// UUID
    static func uuid() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    // MARK: - 获取iOS设备型号

    /// 获取iOS设备型号
    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod1,1": return "iPod Touch 1"
        case "iPod2,1": return "iPod Touch 2"
        case "iPod3,1": return "iPod Touch 3"
        case "iPod4,1": return "iPod Touch 4"
        case "iPod5,1": return "iPod Touch (5 Gen)"
        case "iPod7,1": return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4s"
        case "iPhone5,1": return "iPhone 5"
        case "iPhone5,2": return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3": return "iPhone 5c (GSM)"
        case "iPhone5,4": return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1": return "iPhone 5s (GSM)"
        case "iPhone6,2": return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6s"
        case "iPhone8,2": return "iPhone 6s Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1": return "国行、日版、港行iPhone 7"
        case "iPhone9,2": return "港行、国行iPhone 7 Plus"
        case "iPhone9,3": return "美版、台版iPhone 7"
        case "iPhone9,4": return "美版、台版iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7": return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3": return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6": return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3": return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6": return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9": return "iPad Mini 3"
        case "iPad5,1", "iPad5,2": return "iPad Mini 4"
        case "iPad5,3", "iPad5,4": return "iPad Air 2"
        case "iPad6,3", "iPad6,4": return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8": return "iPad Pro 12.9"
        case "AppleTV2,1": return "Apple TV 2"
        case "AppleTV3,1", "AppleTV3,2": return "Apple TV 3"
        case "AppleTV5,3": return "Apple TV 4"
        case "i386", "x86_64": return "Simulator"
        default: return identifier
        }
    }
}
