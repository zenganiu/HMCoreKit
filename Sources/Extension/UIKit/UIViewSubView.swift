//
//  Ex_UIViewSubView.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

// MARK: - 大小位置变化

public extension UIView {
    // MARK: - 添加多个子视图，注意顺序

    /// 添加多个子视图，注意顺序
    /// - Parameter views: 子视图数组
    func hm_addSubviews(_ views: [UIView]) {
        views.forEach { [weak self] eachView in
            self?.addSubview(eachView)
        }
    }

    // MARK: - 添加多个子视图，注意顺序

    /// 添加多个子视图，注意顺序
    /// - Parameter views: 子视图数组
    func hm_addSubviews(_ views: UIView...) {
        hm_addSubviews(views)
    }

    // MARK: - 移除所有子视图

    /// 移除所有子视图
    func hm_removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    // MARK: - 调整此视图的大小，使其适合最大的子视图

    /// 调整此视图的大小，使其适合最大的子视图
    func hm_resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in subviews {
            let aView = someView
            let newWidth = aView.hm_x + aView.hm_width
            let newHeight = aView.hm_y + aView.hm_height
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        frame = CGRect(x: hm_x, y: hm_y, width: width, height: height)
    }

    // MARK: - 调整此视图的大小，使其适合最大的子视图

    /// 调整此视图的大小，使其适合最大的子视图
    /// - Parameter tagsToIgnore: 忽略特点tag值的子视图
    func hm_resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.hm_x + aView.hm_width
                let newHeight = aView.hm_y + aView.hm_height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: hm_x, y: hm_y, width: width, height: height)
    }

    // MARK: - 调整视图的大小以适合其宽度

    /// 调整视图的大小以适合其宽度
    func hm_resizeToFitWidth() {
        let currentHeight = hm_height
        sizeToFit()
        frame.hm_height = currentHeight
    }

    // MARK: - 调整视图的大小以适合其高度

    /// 调整视图的大小以适合其高度
    func hm_resizeToFitHeight() {
        let currentWidth = hm_width
        sizeToFit()
        frame.hm_width = currentWidth
    }

    // MARK: - 获取视图最左边缘向左偏移

    /// 获取视图最左边缘向左偏移
    /// - Parameter offset: 偏移量
    func hm_leftOffset(_ offset: CGFloat) -> CGFloat {
        return hm_left - offset
    }

    // MARK: - 视图最右边缘向右偏移

    /// 视图最右边缘向右偏移
    /// - Parameter offset: 偏移量
    func hm_rightOffset(_ offset: CGFloat) -> CGFloat {
        return hm_right + offset
    }

    // MARK: - 视图最顶部边缘向上偏移

    /// 视图最顶部边缘向上偏移
    /// - Parameter offset: 偏移量
    func hm_topOffset(_ offset: CGFloat) -> CGFloat {
        return hm_top - offset
    }

    // MARK: - 视图最底部边缘向下偏移

    /// 视图最底部边缘向下偏移
    /// - Parameter offset: 偏移量
    func hm_bottomOffset(_ offset: CGFloat) -> CGFloat {
        return hm_bottom + offset
    }

    // MARK: - 宽度缩小

    /// 宽度缩小
    /// - Parameter offset: 偏移量
    func hm_alignRight(_ offset: CGFloat) -> CGFloat {
        return hm_width - offset
    }

    /// EZSwiftExtensions
    func hm_reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !someView.isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }

    // MARK: - 在父视图中水平居中

    /// 在父视图中水平居中
    func hm_centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("Error: The view \(self) doesn't have a superview")
            return
        }
        hm_x = parentView.hm_width / 2 - hm_width / 2
    }

    // MARK: - 在父视图中垂直居中

    /// 在父视图中垂直居中
    func hm_centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("Error: The view \(self) doesn't have a superview")
            return
        }
        hm_y = parentView.hm_height / 2 - hm_height / 2
    }

    // MARK: - 在父视图中居中

    /// 在父视图中居中
    func hm_centerInSuperView() {
        hm_centerXInSuperView()
        hm_centerYInSuperView()
    }
}
