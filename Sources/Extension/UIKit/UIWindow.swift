//
//  Ex_UIWindow.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension UIWindow {
    /// 切换根视图控制器
    /// - Parameters:
    ///   - rootVC: 控制器
    ///   - options: 动画类型
    ///   - completion: 完成后回调
    func hm_switchRootVC(rootVC: UIViewController,
                         options: UIView.AnimationOptions = .transitionCrossDissolve,
                         completion: (() -> Void)? = nil) {
        rootVC.modalTransitionStyle = .flipHorizontal
        UIView.transition(with: self, duration: 0.5, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = rootVC
            UIView.setAnimationsEnabled(oldState)

        }, completion: {
            completed in

            if completed {
                completion?()
            }
        })
    }
}
