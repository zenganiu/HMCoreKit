//
//  Ex_Int.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/27.
//  Copyright © 2019 huimin. All rights reserved.
//

#if canImport(CoreGraphics)
    import CoreGraphics
#endif

extension Int: HMNameSpaceCompatible {}
public extension HMNameSpace where Base == Int {
    // MARK: - 角度转换成弧度

    /// 角度转换成弧度
    var degreesToRadians: Double {
        return Double.pi * Double(base) / 180.0
    }

    // MARK: - 弧度转换成角度

    /// 弧度转换成角度
    var radiansToDegrees: Double {
        return Double(base) * 180 / Double.pi
    }

    // MARK: - 转换成无符号整型

    /// UInt
    var uInt: UInt {
        return UInt(base)
    }

    /// Double
    var double: Double {
        return Double(base)
    }

    /// Float
    var float: Float {
        return Float(base)
    }

    #if canImport(CoreGraphics)
        /// CGFloat
        var cgFloat: CGFloat {
            return CGFloat(base)
        }
    #endif

    // MARK: - 数字数组 (高位在前)

    /// 数字数组 (高位在前)
    var digits: [Int] {
        guard base != 0 else { return [0] }
        var digits = [Int]()
        var number = Swift.abs(base)
        while number != 0 {
            let xNumber = number % 10
            digits.append(xNumber)
            number /= 10
        }
        digits.reverse()
        return digits
    }

    // MARK: - 位数

    /// 位数
    var digitsCount: Int {
        guard base != 0 else { return 1 }
        let number = Swift.abs(base).hm.double
        return Int(log10(number) + 1)
    }
}
