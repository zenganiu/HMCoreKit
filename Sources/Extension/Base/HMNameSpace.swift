//
//  NameSpace.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/26.
//  Copyright © 2019 huimin. All rights reserved.
//

// MARK: - 命名空间

public struct HMNameSpace<Base> {
    public var base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

// 协议
public protocol HMNameSpaceCompatible {
    associatedtype CompatibleType
    /// 命名空间扩展
    var hm: HMNameSpace<CompatibleType> { get set }
    /// 命名空间扩展
    static var hm: HMNameSpace<CompatibleType>.Type { get set }
}

// 默认实现
public extension HMNameSpaceCompatible {
    var hm: HMNameSpace<Self> {
        get {
            return HMNameSpace(self)
        }
        set {
            // self.hm = newValue
        }
    }

    static var hm: HMNameSpace<Self>.Type {
        get {
            return HMNameSpace<Self>.self
        }
        set {
            // self.hm = newValue
        }
    }
}

import class Foundation.NSObject
extension NSObject: HMNameSpaceCompatible {}
