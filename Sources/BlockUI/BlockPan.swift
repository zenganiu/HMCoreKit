//
//  BlockPan.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 拖拽手势
open class BlockPan: UIPanGestureRecognizer {
    /// 拖拽手势闭包
    private var panAction: ((UIPanGestureRecognizer) -> Void)?

    override public init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(action: ((UIPanGestureRecognizer) -> Void)?) {
        self.init()
        panAction = action
        addTarget(self, action: #selector(BlockPan.didPan(_:)))
    }

    @objc open func didPan(_ pan: UIPanGestureRecognizer) {
        panAction? (pan)
    }
}
