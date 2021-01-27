//
//  Ex_UIStoryboard.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension HMNameSpace where Base: UIStoryboard {
    /// 获取storyboard中控制器
    /// - Parameter name: storyboard名称
    /// - Parameter vc: 控制器类型
    /// - Parameter identifier: 标识符；nil为类名
    static func initViewController<T: UIViewController>(name: String, vc: T.Type, identifier: String? = nil) -> T {
        let ident = identifier == nil ? T.hm_className : identifier!
        let bundle = Bundle(for: vc.self)
        if #available(iOS 13.0, *) {
            let vc = UIStoryboard(name: name, bundle: bundle).instantiateViewController(identifier: ident)
            return vc as! T
        } else {
            let vc = UIStoryboard(name: name, bundle: bundle).instantiateViewController(withIdentifier: ident)
            return vc as! T
        }
    }
}
