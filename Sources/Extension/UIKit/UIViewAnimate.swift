//
//  Ex_UIViewAnimate.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

// MARK: - 动画

public extension UIView {
    // MARK: - 弹簧动画

    /// 弹簧动画
    /// - Parameter duration: 时间
    /// - Parameter animations: 动画闭包
    /// - Parameter completion: 完成闭包
    static func hm_spring(duration: TimeInterval = 1,
                          animations: @escaping (() -> Void),
                          completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIView.AnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }

    // MARK: - 气泡

    /// 气泡
    func hm_pop() {
        hm_scale(x: 1.1, y: 1.1)
        UIView.hm_spring(duration: 0.2, animations: {
            self.hm_scale(x: 1, y: 1)
        })
    }

    // MARK: - 放大动画

    /// 放大动画
    func hm_popBig() {
        hm_scale(x: 1.25, y: 1.25)
        UIView.hm_spring(duration: 0.2, animations: {
            self.hm_scale(x: 1, y: 1)
        })
    }

    // MARK: - 缩小动画

    /// 缩小动画
    func hm_reversePop() {
        hm_scale(x: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.05, delay: 0, options: .allowUserInteraction, animations: {
            self.hm_scale(x: 1, y: 1)
        }, completion: { _ in })
    }

    // MARK: - 视图抖动

    /// 视图抖动
    /// - Parameter times: 时间 s
    func hm_shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0)),
            NSValue(caTransform3D: CATransform3DMakeTranslation(5, 0, 0)),
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7 / 100
        layer.add(anim, forKey: nil)
    }
}

public let UIViewDefaultFadeDuration: TimeInterval = 0.4
public extension UIView {
    /// EZSE: Fade in with duration, delay and completion block.
    func hm_fadeIn(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        hm_fadeTo(1.0, duration: duration, delay: delay, completion: completion)
    }

    /// EZSwiftExtensions
    func hm_fadeOut(_ duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        hm_fadeTo(0.0, duration: duration, delay: delay, completion: completion)
    }

    /// Fade to specific value     with duration, delay and completion block.
    func hm_fadeTo(_ value: CGFloat, duration: TimeInterval? = UIViewDefaultFadeDuration, delay: TimeInterval? = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration ?? UIViewDefaultFadeDuration, delay: delay ?? UIViewDefaultFadeDuration, options: .curveEaseInOut, animations: {
            self.alpha = value
        }, completion: completion)
    }
}
