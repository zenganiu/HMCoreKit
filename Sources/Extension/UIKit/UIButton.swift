//
//  Ex_Button.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

// MARK: - 倒计时器

public extension UIButton {
    // MARK: - 取消按钮倒计时

    /// 取消按钮倒计时
    /// - Parameter backgroundColor: 按钮背景颜色
    func hm_cancelTimer(backgroundColor: UIColor) {
        DispatchQueue.main.async(execute: {
            self.isEnabled = true
            self.backgroundColor = backgroundColor
            self.timer?.cancel()
            self.timer = nil
        })
    }

    private struct Key {
        static var timerKey = "hm_timerKey"
    }

    // MARK: - 通过关联属性给UIButton添加一个timer属性，主要用来取消定时

    // 通过关联属性给UIButton添加一个timer属性，主要用来取消定时
    private var timer: DispatchSourceTimer? {
        // 在调用DispatchSourceTimer时, 无论设置timer.scheduleOneshot, 还是timer.scheduleRepeating代码 不调用cancel(), 系统会自动调用
        // 另外需要设置全局变量引用, 否则不会调用事件
        get {
            return objc_getAssociatedObject(self, &Key.timerKey) as? DispatchSourceTimer
        }
        set {
            objc_setAssociatedObject(self, &Key.timerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    // MARK: - 开启倒计时

    /// 开启倒计时
    /// - Parameters:
    ///   - duration: 时间(秒)
    ///   - disableBackGroudColor: 按钮不可点击是背景颜色
    ///   - disableTitleColor: 按钮不可点击时文本颜色
    func hm_startSMSWithDuration(duration: Int,
                                 disableBackGroudColor: UIColor = .gray,
                                 disableTitleColor: UIColor = .white) {
        var times = duration
        let normalBGColor = backgroundColor
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        timer?.setEventHandler {
            if times > 0 {
                DispatchQueue.main.async(execute: {
                    self.isEnabled = false
                    self.setTitle("重新获取\(times)", for: .disabled)
                    self.setTitleColor(disableTitleColor, for: .disabled)
                    self.backgroundColor = disableBackGroudColor
                    times -= 1
                })
            } else {
                DispatchQueue.main.async(execute: {
                    self.isEnabled = true
                    self.backgroundColor = normalBGColor
                    self.timer?.cancel()
                    self.timer = nil
                })
            }
        }
        // timer.scheduleOneshot(deadline: .now())
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(100))
        timer?.resume()
        // 在调用DispatchSourceTimer时, 无论设置timer.scheduleOneshot, 还是timer.scheduleRepeating代码 不调用cancel(), 系统会自动调用
        // 另外需要设置全局变量引用, 否则不会调用事件
    }
}

// MARK: - 点击事件闭包

public extension UIButton {
    typealias UIButtonTargetClosure = () -> Void

    private class ClosureWrapper: NSObject {
        let closure: UIButtonTargetClosure
        init(_ closure: @escaping UIButtonTargetClosure) {
            self.closure = closure
        }
    }

    private struct AssociatedKeys {
        static var targetClosure = "targetClosure"
    }

    private var targetClosure: UIButtonTargetClosure? {
        get {
            guard let closureWrapper = objc_getAssociatedObject(self, &AssociatedKeys.targetClosure) as? ClosureWrapper else { return nil }
            return closureWrapper.closure
        }
        set(newValue) {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.targetClosure, ClosureWrapper(newValue), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// 按钮点击事件
    /// - Parameter action: 点击事件回调闭包
    func target(_ action: @escaping UIButtonTargetClosure) {
        targetClosure = action
        addTarget(self, action: #selector(UIButton.targetAction), for: .touchUpInside)
    }

    @objc private func targetAction() {
        guard let targetClosure = targetClosure else { return }
        targetClosure()
    }
}

// MARK: - 属性

public extension UIButton {
    // MARK: - 设置背景色

    /// 设置背景色
    /// - Parameter color: 颜色
    /// - Parameter forState: 状态
    func hm_setBackgroundColor(_ color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: forState)
    }

    // MARK: - 设置/获取按钮不可用图片

    /// 设置/获取按钮不可用图片
    var hm_imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }

    // MARK: - 设置/获取按钮高亮图片

    /// 设置/获取按钮高亮图片
    var hm_imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }

    // MARK: - 设置/获取按钮正常图片

    /// 设置/获取按钮正常图片
    var hm_imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    // MARK: - 设置/获取按钮选择图片

    /// 设置/获取按钮选择图片
    var hm_imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    // MARK: - 设置/获取按钮不可用标题

    /// 设置/获取按钮不可用标题
    var hm_titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }

    // MARK: - 设置/获取按钮高亮标题

    /// 设置/获取按钮高亮标题
    var hm_titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }

    // MARK: - 设置/获取按钮正常标题

    /// 设置/获取按钮正常标题
    var hm_titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    // MARK: - 设置/获取按钮标题选择颜色

    /// 设置/获取按钮标题选择颜色
    var hm_titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    // MARK: - 设置/获取按钮不可用时标题

    /// 设置/获取按钮不可用时标题
    var hm_titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }

    // MARK: - 设置/获取按钮高亮时标题

    /// 设置/获取按钮高亮时标题
    var hm_titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }

    // MARK: - 设置/获取按钮通用时标题

    /// 设置/获取按钮通用时标题
    var hm_titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    // MARK: - 设置/获取按钮选中时标题

    /// 设置/获取按钮选中时标题
    var hm_titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
}
