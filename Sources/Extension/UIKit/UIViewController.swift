//
//  Ex_UIViewController.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension UIViewController {
    // MARK: - 添加子视图

    /// 添加子视图
    /// - Parameter aview: 子视图
    func hm_addSubview(_ aview: UIView) {
        view.addSubview(aview)
    }

    // MARK: - 添加多个子视图

    /// 添加多个子视图
    /// - Parameter aviews: 子视图数组
    func hm_addSubViews(_ aviews: [UIView]) {
        view.hm_addSubviews(aviews)
    }

    // MARK: - 添加多个子视图

    /// 添加多个子视图
    /// - Parameter aviews: 子视图数组
    func hm_addSubViews(_ aviews: UIView...) {
        view.hm_addSubviews(aviews)
    }

    // MARK: - 添加子控制器

    /// 添加子控制器
    /// - Parameter child: 子控制器
    /// - Parameter containerView: 子view
    func hm_addChildViewController(_ child: UIViewController, toContainerView containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    // MARK: - 移除子控制器、子视图

    /// 移除子控制器、子视图
    func hm_removeViewAndControllerFromParentViewController() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}

// MARK: - 转场

public extension UIViewController {
    // MARK: - 模态推出新控制器

    /// 模态推出新控制器
    /// - Parameter vc: 新控制器
    /// - Parameter style: 风格
    /// - Parameter completion: 完成后回调
    func hm_presentVC(_ vc: UIViewController, style: UIModalPresentationStyle = .fullScreen, completion: (() -> Swift.Void)? = nil) {
        vc.modalPresentationStyle = style
        present(vc, animated: true, completion: completion)
    }

    // MARK: - 模态返回

    /// 模态返回
    func hm_dismissVC(animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }

    // MARK: - push

    /// push
    /// - Parameter vc: 新控制器
    func hm_pushVC(_ vc: UIViewController, animated: Bool = true) {
        if let pvc = self as? UINavigationController {
            pvc.pushViewController(vc, animated: animated)
        } else {
            navigationController?.pushViewController(vc, animated: animated)
        }
    }

    // MARK: - pop

    /// pop
    /// - Parameter toViewController: 为空，pop到上一个控制器
    func hm_popVC(to viewController: UIViewController? = nil) {
        guard let tovc = viewController else {
            navigationController?.popViewController(animated: true)
            return
        }
        navigationController?.popToViewController(tovc, animated: true)
    }

    // MARK: - pop到最顶层控制器

    /// pop到最顶层控制器
    func hm_popRootVC() {
        navigationController?.popToRootViewController(animated: true)
    }

    // MARK: - 查找控制器

    /// 查找控制器；通过响应链
    /// - Parameter controller: 待查找的控制器
    func hm_findController<T: UIViewController>(controller: T.Type) -> T? {
        if let vc = self as? T {
            return vc
        }

        var viewController: T?
        var next = self.next
        while next != nil {
            if let vc = next as? T {
                viewController = vc
                break
            }
            next = next?.next
        }
        return viewController
    }

    // MARK: - 气泡弹窗

    /// 气泡弹窗
    /// - Parameter popoverContent: 弹出的视图控制器
    /// - Parameter sourcePoint: 弹出位置
    /// - Parameter size: 弹出大小
    /// - Parameter delegate: 视图控制器代理
    /// - Parameter animated: 动画
    /// - Parameter completion: 完成后回调
    func hm_presentPopover(_ popoverContent: UIViewController,
                           sourcePoint: CGPoint,
                           size: CGSize? = nil,
                           delegate: UIPopoverPresentationControllerDelegate? = nil,
                           animated: Bool = true,
                           completion: (() -> Void)? = nil) {
        popoverContent.modalPresentationStyle = .popover

        if let size = size {
            popoverContent.preferredContentSize = size
        }

        if let popoverPresentationVC = popoverContent.popoverPresentationController {
            popoverPresentationVC.sourceView = view
            popoverPresentationVC.sourceRect = CGRect(origin: sourcePoint, size: .zero)
            popoverPresentationVC.delegate = self
        }

        present(popoverContent, animated: animated, completion: completion)
    }
}

extension UIViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .popover
    }
}
