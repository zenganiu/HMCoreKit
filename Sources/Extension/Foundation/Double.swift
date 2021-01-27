//
//  Ex_Double.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/27.
//  Copyright © 2019 huimin. All rights reserved.
//


#if canImport(CoreGraphics)
import CoreGraphics
#endif

extension Double: HMNameSpaceCompatible{}
// MARK: - 属性
public extension HMNameSpace where Base == Double {
    /// 转换为整型数
    var int: Int {
        return Int(base)
    }
    /// 转换为单精度浮点数
    var float: Float {
        return Float(base)
    }
    /// 转换为无符号的整型数
    var uint64: UInt64{
        return UInt64(base)
    }
    #if canImport(CoreGraphics)
    /// 转换为CGFloat
    var cgFloat: CGFloat {
        return CGFloat(base)
    }
    #endif
}
