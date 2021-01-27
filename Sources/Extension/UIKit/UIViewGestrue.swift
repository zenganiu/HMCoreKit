//
//  Ex_UIViewGestrue.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//

#if canImport(UIKit)
import UIKit

// MARK: - 手势
public extension UIView {
    //MARK:- 添加点击手势(Selector)
    /// 添加点击手势(Selector)
    func hm_addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    //MARK:- 添加点击手势(闭包)；避免引用循环
    /// 添加点击手势 (使用[weak self] 避免引用循环)
    /// - Parameter tapNumber: 点击次数
    /// - Parameter action: 响应回调
    func hm_addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    //MARK:- 添加轻扫手势(Selector)
    /// 添加轻扫手势(Selector)
    func hm_addSwipeGesture(direction: UISwipeGestureRecognizer.Direction, numberOfTouches: Int = 1, target: AnyObject, action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction
        #if os(iOS)
        swipe.numberOfTouchesRequired = numberOfTouches
        #endif
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    //MARK:- 添加轻扫手势(闭包)；避免引用循环
    /// 添加轻扫手势(闭包)；避免引用循环
    func hm_addSwipeGesture(direction: UISwipeGestureRecognizer.Direction, numberOfTouches: Int = 1, action: ((UISwipeGestureRecognizer) -> Void)?) {
        let swipe = BlockSwipe(direction: direction, fingerCount: numberOfTouches, action: action)
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    //MARK:- 添加拖动手势(Selector)
    /// 添加拖动手势(Selector)
    func hm_addPanGesture(target: AnyObject, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    //MARK:- 添加拖动手势(闭包)；避免引用循环
    /// 添加拖动手势(闭包)；避免引用循环
    func hm_addPanGesture(action: ((UIPanGestureRecognizer) -> Void)?) {
        let pan = BlockPan(action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    #if os(iOS)
    //MARK:- 添加捏合手势(Selector)
    /// 添加捏合手势(Selector)
    func hm_addPinchGesture(target: AnyObject, action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    #endif
    #if os(iOS)
    //MARK:- 添加捏合手势(闭包)；避免引用循环
    /// 添加捏合手势(闭包)；避免引用循环
    func hm_addPinchGesture(action: ((UIPinchGestureRecognizer) -> Void)?) {
        let pinch = BlockPinch(action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    #endif
    //MARK:- 添加长按手势(Selector)
    /// 添加长按手势(Selector)
    func hm_addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
    //MARK:- 添加长按手势（闭包）；避免引用循环
    /// 添加长按手势（闭包）；避免引用循环
    func hm_addLongPressGesture(action: ((UILongPressGestureRecognizer) -> Void)?) {
        let longPress = BlockLongPress(action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}
#endif
