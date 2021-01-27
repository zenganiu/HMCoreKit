//
//  Ex_NSObject.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation

public extension NSObject {
    /// 获取类名
    static var hm_className: String {
        guard let name = NSStringFromClass(self).components(separatedBy: ".").last else {
            return ""
        }
        return name
    }

    /// 移除所有通知
    func hm_removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
