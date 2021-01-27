//
//  Ex_UIViewTransform.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

// MARK: - 图像变换
public extension UIView {
    // MARK: - x轴旋转

    /// x轴旋转
    /// - Parameter x: 角度
    func hm_rotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.hm.degreesToRadians, 1.0, 0.0, 0.0)
        layer.transform = transform
    }

    // MARK: - y轴旋转

    ///  y轴旋转
    /// - Parameter y: 角度
    func hm_rotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.hm.degreesToRadians, 0.0, 1.0, 0.0)
        layer.transform = transform
    }

    // MARK: - z轴旋转

    /// z轴旋转
    /// - Parameter z: 角度
    func hm_rotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.hm.degreesToRadians, 0.0, 0.0, 1.0)
        layer.transform = transform
    }

    // MARK: - 旋转

    /// 旋转
    /// - Parameter x: 角度
    /// - Parameter y: 角度
    /// - Parameter z: 角度
    func hm_rotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.hm.degreesToRadians, 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.hm.degreesToRadians, 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.hm.degreesToRadians, 0.0, 0.0, 1.0)
        layer.transform = transform
    }

    // MARK: - 缩放

    /// 缩放
    /// - Parameter x: 倍率
    /// - Parameter y: 倍率
    func hm_scale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        layer.transform = transform
    }
}
