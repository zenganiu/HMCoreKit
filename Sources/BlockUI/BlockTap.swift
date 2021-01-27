//
//  BlockTap.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 点击手势
open class BlockTap: UITapGestureRecognizer {
    /// 点击手势事件
    private var tapAction: ((UITapGestureRecognizer) -> Void)?

    override public init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(
        tapCount: Int = 1,
        fingerCount: Int = 1,
        action: ((UITapGestureRecognizer) -> Void)?
    ) {
        self.init()
        numberOfTapsRequired = tapCount
        #if os(iOS)
            numberOfTouchesRequired = fingerCount
        #endif

        tapAction = action
        addTarget(self, action: #selector(BlockTap.didTap(_:)))
    }

    @objc open func didTap(_ tap: UITapGestureRecognizer) {
        tapAction? (tap)
    }
}
