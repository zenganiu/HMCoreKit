//
//  BlockLongPress.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 长按手势
open class BlockLongPress: UILongPressGestureRecognizer {
    
    /// 长按手势事件闭包
    private var longPressAction: ((UILongPressGestureRecognizer) -> Void)?

    public override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }

    public convenience init(action: ((UILongPressGestureRecognizer) -> Void)?) {
        self.init()
        longPressAction = action
        addTarget(self, action: #selector(BlockLongPress.didLongPressed(_:)))
        minimumPressDuration = 2
    }

    @objc public func didLongPressed(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == UIGestureRecognizer.State.began {
            longPressAction?(longPress)
        }
    }
}
