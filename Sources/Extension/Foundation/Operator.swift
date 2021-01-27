//
//  Operator.swift
//  HMCoreKit
//
//  Created by huimin on 2020/4/5.
//  Copyright © 2020 huimin. All rights reserved.
//

import Foundation

// MARK: -数组比较

public func == <T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

// MARK: -可选值比较

/// 可选值比较
/// - Parameter lhs: 左值
/// - Parameter rhs: 右值
public func == <T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (lhs?, rhs?):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}

public func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    return ns
}

public func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}
