//
//  BlockSwipe.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 轻扫手势
open class BlockSwipe: UISwipeGestureRecognizer {
    /// 轻扫手势闭包
    private var swipeAction: ((UISwipeGestureRecognizer) -> Void)?

    override public init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(
        direction: UISwipeGestureRecognizer.Direction,
        fingerCount: Int = 1,
        action: ((UISwipeGestureRecognizer) -> Void)?
    ) {
        self.init()
        self.direction = direction

        #if os(iOS)

            numberOfTouchesRequired = fingerCount

        #endif

        swipeAction = action
        addTarget(self, action: #selector(BlockSwipe.didSwipe(_:)))
    }

    @objc open func didSwipe(_ swipe: UISwipeGestureRecognizer) {
        swipeAction? (swipe)
    }
}
