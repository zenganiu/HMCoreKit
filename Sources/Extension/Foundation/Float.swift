//
//  Ex_Float.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/27.
//  Copyright © 2019 huimin. All rights reserved.
//

#if canImport(CoreGraphics)
import CoreGraphics
#endif

extension Float: HMNameSpaceCompatible{}
// MARK: - 属性
public extension HMNameSpace where Base == Float {
    ///Int
    var int: Int {
        return Int(self.base)
    }
    /// Double.
    var double: Double {
        return Double(self.base)
    }
    #if canImport(CoreGraphics)
    /// CGFloat.
    var cgFloat: CGFloat {
        return CGFloat(self.base)
    }
    #endif
}
