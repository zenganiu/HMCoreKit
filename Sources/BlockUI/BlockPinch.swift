//
//  BlockPinch.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 缩放手势
open class BlockPinch: UIPinchGestureRecognizer {
    /// 缩放手势事件
    private var pinchAction: ((UIPinchGestureRecognizer) -> Void)?

    override public init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(action: ((UIPinchGestureRecognizer) -> Void)?) {
        self.init()
        pinchAction = action
        addTarget(self, action: #selector(BlockPinch.didPinch(_:)))
    }

    @objc open func didPinch(_ pinch: UIPinchGestureRecognizer) {
        pinchAction? (pinch)
    }
}
