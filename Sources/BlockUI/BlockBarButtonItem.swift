//
//  BlockBarButtonItem.swift
//  HMCoreKit
//
//  Created by huimin on 2020/8/9.
//  Copyright © 2020 huimin. All rights reserved.
//

import UIKit

open class BlockBarButtonItem: UIBarButtonItem {
    private var tapAction: ((UIBarButtonItem) -> Void)?

    public init(title: String?, style: UIBarButtonItem.Style, action: ((UIBarButtonItem) -> Void)?) {
        super.init()
        tapAction = action
        self.title = title
        self.style = style
        self.action = #selector(tap(sender:))
        target = self
    }

    public init(image: UIImage?, style: UIBarButtonItem.Style, action: ((UIBarButtonItem) -> Void)?) {
        super.init()
        tapAction = action
        self.image = image
        self.style = style
        self.action = #selector(tap(sender:))
        target = self
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tap(sender: UIBarButtonItem) {
        tapAction?(sender)
    }
}
