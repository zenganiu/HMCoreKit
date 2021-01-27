//
//  UIAlertController.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension UIAlertController {
    /// 添加默认样式的Action
    /// - Parameters:
    ///   - title: 标题
    ///   - complection: 点击事件闭包
    func hm_addAction(title: String, complection: @escaping () -> Void) {
        let action = UIAlertAction(title: title, style: .default) { _ in
            complection()
        }
        addAction(action)
    }

    /// 添加Destructive样式的Action
    /// - Parameters:
    ///   - title: 标题
    ///   - complection: 点击事件闭包
    func hm_addDestructiveAction(title: String, complection: @escaping () -> Void) {
        let action = UIAlertAction(title: title, style: .destructive) { _ in
            complection()
        }
        addAction(action)
    }

    /// 添加Cancel样式的Action
    /// - Parameters:
    ///   - title: 标题
    ///   - complection: 点击事件闭包
    func hm_addCancelAction(title: String, complection: @escaping () -> Void = {}) {
        let action = UIAlertAction(title: title, style: .cancel) { _ in
            complection()
        }
        addAction(action)
    }

    func hm_addTextFiled() {
        addTextField { _ in
        }
    }

    // MARK: - Alert样式

    /// Alert样式
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - buttonTitle: 按钮标题
    ///   - cancelButtonTitle: 取消按钮标题
    ///   - complection: 点击事件闭包
    ///   - viewController: form VC
    static func hm_alert(title: String?,
                         message: String? = nil,
                         buttonTitle: String,
                         cancelButtonTitle: String? = nil,
                         on viewController: UIViewController? = HM.topVC(),
                         complection: @escaping () -> Void = {}) {
        let ac = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        if let cancelTitle = cancelButtonTitle {
            ac.addAction(UIAlertAction(
                title: cancelTitle,
                style: UIAlertAction.Style.cancel,
                handler: nil)
            )
        }
        ac.addAction(UIAlertAction(
            title: buttonTitle,
            style: UIAlertAction.Style.default,
            handler: { _ in
                complection()
        }))

        ac.hm_show(on: viewController)
    }

    /// 显示弹窗，默认为 topVC
    func hm_show(on viewController: UIViewController? = HM.topVC()) {
        guard let vc = viewController else {
            return
        }
        vc.hm_presentVC(self)
    }
}
