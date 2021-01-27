//
//  Ex_UIViewNormal.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

// MARK: - 构造方法

public extension UIView {

    // MARK: - 便利构造函数，在视图周围添加边距

    /// 便利构造函数，在视图周围添加边距
    /// - Parameter superView: 父视图
    /// - Parameter padding: 内边距
    convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.hm_x + padding,
                                y: superView.hm_y + padding,
                                width: superView.hm_width - padding * 2,
                                height: superView.hm_height - padding * 2))
    }

    // MARK: - 便利构造函数，与父视图大小一样

    /// 便利构造函数，与父视图大小一样
    /// - Parameter superView: 父视图
    convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.hm_size))
    }

    convenience init(color: UIColor) {
        self.init(frame: .init(x: 0, y: 0, width: HM.width, height: HM.height))
        backgroundColor = color
    }
}

// MARK: -从nib加载视图

public extension UIView {
    // MARK: - 从nib加载视图

    /// 从nib加载视图
    class func hm_loadNib() -> Self {
        return hm_loadNib(self)
    }

    private class func hm_loadNib<T: UIView>(_ viewType: T.Type) -> T {
        let className = viewType.hm_className
        return Bundle(for: viewType).loadNibNamed(className, owner: nil, options: nil)!.first as! T
    }
}

public extension UIView {
    // MARK: - 获取view所在的控制器

    /// 获取某个view所在的控制器
    func hm_viewController() -> UIViewController? {
        var viewController: UIViewController?
        var next = self.next
        while next != nil {
            if let vc = next as? UIViewController {
                viewController = vc
                break
            }
            next = next?.next
        }
        return viewController
    }

    // MARK: - 获取某个view所在的控制器

    /// 获取某个view所在的控制器
    func hm_findController<T: UIViewController>(controller: T.Type) -> T? {
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

    // MARK: - 转换图片

    /// 转换图片
    func hm_toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }

    // MARK: - 视图最顶层的视图

    /// 视图最顶层的视图
    func hm_rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.hm_rootView()
    }

    // MARK: - 设置视图的抗拉伸、压缩优先级

    /// 设置视图的抗拉伸、压缩优先级
    func hm_setHugAndCompress(priority: Float, axis: NSLayoutConstraint.Axis) {
        setContentHuggingPriority(.init(priority), for: axis)
        setContentCompressionResistancePriority(.init(priority), for: axis)
    }
}
