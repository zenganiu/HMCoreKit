//
//  HM.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/12.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 全局变量使用前缀
public enum HM {
    // MARK: - 始终输出日志，true始终输出

    /// 始终输出日志，true始终输出
    static var isAlwaysLogger: Bool = false
}

// MARK: - 全局函数

public extension HM {
    // MARK: - 查找当前显示的控制器

    /// 查找当前显示的控制器
    static func topVC() -> UIViewController? {
        // 获取根视图控制器
        guard let window = UIApplication.shared.keyWindow, let rootVC = window.rootViewController else {
            return nil
        }
        // 查找最顶层的VC
        var topVC = rootVC
        while true {
            if let vc = topVC.presentedViewController {
                topVC = vc
            } else if let vc = (topVC as? UINavigationController)?.topViewController {
                topVC = vc
            } else if let vc = (topVC as? UITabBarController)?.selectedViewController {
                topVC = vc
            } else {
                break
            }
        }
        return topVC
    }

    // MARK: - 获取类名字符串

    /// 获取类名字符串,失败返回空字符
    /// - Parameter class: 类
    static func className(_ aClass: AnyClass) -> String {
        guard let name = NSStringFromClass(aClass).components(separatedBy: ".").last else {
            return ""
        }
        return name
    }

    // MARK: - 日志打印

    /// 日志打印
    /// - Parameters:
    ///   - file: 文件名
    ///   - function: 调用函数
    ///   - line: 所在行
    ///   - title: 标题
    ///   - content: 打印内容
    /// - Returns: 日志字符串
    @discardableResult
    static func logger(file: String = #file,
                       function: String = #function,
                       line: Int = #line,
                       title: String = "内容",
                       content: Any?...) -> String {
        var s: String = ""
        for item in content {
            s.append("\(item ?? "nil")\n")
        }

        let logStr = "Logger: [\(Date().hm.toString())] [\(file.hm.nsString.lastPathComponent)] [\(function)] [\(line)]\n\(title): \(s)"
        if HM.isAlwaysLogger || HMApp.isDebug {
            print(logStr)
        }
        return logStr
    }

    // MARK: - 主线程异步延迟操作

    /// 主线程异步延迟操作
    /// - Parameter second: 延迟时间(秒)
    /// - Parameter closure: 回调闭包
    static func dispatchDelay(_ second: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(second * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

    // MARK: - 地址打印

    /// 打印对象的内存地址
    /// - Parameter values: 对象数组
    static func printAddress(values: AnyObject...) {
        var arr: [UnsafeMutableRawPointer] = []
        for value in values {
            let addr = Unmanaged.passUnretained(value).toOpaque()
            arr.append(addr)
        }
        HM.logger(title: "对象地址", content: arr)
    }

    /// 打印普通变量地址
    /// - Parameter rows: 变量数组
    static func printAddress(rows: UnsafeRawPointer...) {
        var arr: [String] = []
        for row in rows {
            let p = String(format: "%018p", Int(bitPattern: row))
            arr.append(p)
        }
        HM.logger(title: "变量地址", content: arr)
    }
}

// MARK: - 屏幕尺寸

public extension HM {
    // MARK: - 屏幕宽度

    /// 屏幕宽度
    static var width: CGFloat {
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
    static var height: CGFloat {
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

    // MARK: - 屏幕方向

    /// 屏幕方向
    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }

    // MARK: - 是否是刘海屏

    /// 是否是刘海屏
    static var isIphoneX: Bool {
        return UIScreen.main.bounds.size == CGSize(width: 375, height: 812) ||
            UIScreen.main.bounds.size == CGSize(width: 414, height: 896)
    }

    // MARK: - 导航栏高度

    /// 导航栏高度
    static var navBarH: CGFloat {
        return isIphoneX ? 88 : 64
    }

    // MARK: - 状态栏高度

    /// 状态栏高度
    static var statusBarH: CGFloat {
        return isIphoneX ? 44 : 20
    }

    // MARK: - tabbar高度

    /// tabbar高度
    static var tabBarH: CGFloat {
        return isIphoneX ? 83 : 49
    }

    // MARK: - 屏幕底部安全高度

    /// 屏幕底部安全高度
    static var bottomH: CGFloat {
        return isIphoneX ? 34 : 0
    }
}
