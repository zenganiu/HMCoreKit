//
//  HMApp.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/25.
//  Copyright © 2019 huimin. All rights reserved.
//

import SystemConfiguration
import SystemConfiguration.CaptiveNetwork
import UIKit

/// App全局信息
public enum HMApp { }

public extension HMApp {
    // MARK: - 应用名称

    /// 应用名称
    static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return nil
    }

    // MARK: - 应用版本

    /// 应用版本
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    // MARK: - 应用构建版本

    /// 应用构建版本
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    // MARK: - 应用标识符

    /// 应用标识符
    static var appBundleID: String? {
        return Bundle.main.bundleIdentifier
    }

    // MARK: - 应用版本+构建版本

    static var appVersionAndBuild: String? {
        if appVersion != nil && appBuild != nil {
            if appVersion == appBuild {
                return "v\(appVersion!)"
            } else {
                return "v\(appVersion!)(\(appBuild!))"
            }
        }
        return nil
    }

    /// 设备的UUID
    static var uuid: String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    // MARK: - 设备架构版本

    /// 设备架构版本(x86_64/ARM64)
    static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }

    // MARK: - 是否调试模式

    /// 是否调试模式
    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }

    // MARK: - 是否正式模式

    /// 是否正式模式
    static var isRelease: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }

    // MARK: - 是否是模拟器

    /// 是否是模拟器
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }

    // MARK: - 是否是真机

    /// 是否是真机
    static var isDevice: Bool {
        #if targetEnvironment(simulator)
            return false
        #else
            return true
        #endif
    }

    // MARK: - 是否正在TestFlight

    /// 是否正在TestFlight
    static var isInTestFlight: Bool {
        return Bundle.main.appStoreReceiptURL?.path.contains("sandboxReceipt") == true
    }

    // MARK: - 屏幕方向

    /// 屏幕方向
    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    // MARK: - 屏幕宽度

    /// 屏幕宽度
    static var screenWidth: CGFloat {
        #if os(iOS)
            if screenOrientation.isPortrait {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
        #elseif os(tvOS)
            return UIScreen.main.bounds.size.width
        #endif
    }

    // MARK: - 屏幕高度

    /// 屏幕高度
    static var screenHeight: CGFloat {
        #if os(iOS)
            if screenOrientation.isPortrait {
                return UIScreen.main.bounds.size.height
            } else {
                return UIScreen.main.bounds.size.width
            }
        #elseif os(tvOS)
            return UIScreen.main.bounds.size.height
        #endif
    }

    // MARK: - 顶部状态栏高度

    /// 顶部状态栏高度
    static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }

    // MARK: - 不含状态栏屏幕高度

    /// 不含状态栏屏幕高度
    static var screenHeightWithoutStatusBar: CGFloat {
        if screenOrientation.isPortrait {
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }

    // MARK: - 当前地区

    /// 当前地区
    static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }

    // MARK: - 系统截屏事件

    /// 系统截屏事件
    /// - Parameter action: 回调闭包
    static func detectScreenShot(_ action: @escaping () -> Void) {
        let mainQueue = OperationQueue.main
        _ = NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: mainQueue) { _ in
            // executes after screenshot
            action()
        }
    }

    // MARK: - 拨打电话

    /// 拨打电话
    /// - Parameter phoneNum: 电话
    /// - Parameter completionHandle: 完成回调
    @available(iOS 10.0,*)
    static func call(phoneNum: String, completionHandle: ((Bool) -> Void)?) {
        guard let url = URL(string: "telprompt://\(phoneNum)") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completionHandle)
    }

    // MARK: - 复制文本

    /// 复制文本
    /// - Parameter text: 内容
    static func paste(text: String) {
        let paste = UIPasteboard.general
        paste.string = text
    }

    // MARK: - 获取当前连接SSID

    /// 获取当前连接SSID
    ///
    /// - Returns: SSID
    static func getUsedSSID() -> String {
        let interfaces = CNCopySupportedInterfaces()
        var ssid = ""
        if interfaces != nil {
            let interfacesArray = CFBridgingRetain(interfaces) as! Array<AnyObject>
            if interfacesArray.count > 0 {
                let interfaceName = interfacesArray[0] as! CFString
                let ussafeInterfaceData = CNCopyCurrentNetworkInfo(interfaceName)
                if ussafeInterfaceData != nil {
                    let interfaceData = ussafeInterfaceData as! Dictionary<String, Any>
                    ssid = interfaceData["SSID"]! as! String
                }
            }
        }
        return ssid
    }

    // MARK: - keywindow

    /// 获取应用keywindow
    static func keywindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.first } ?? UIApplication.shared.keyWindow ?? nil
        }
        return UIApplication.shared.keyWindow ?? nil
    }
}
