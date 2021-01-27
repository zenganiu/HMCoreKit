//
//  Ex_CGFloat.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

extension CGFloat: HMNameSpaceCompatible {}

// MARK: - 属性

public extension HMNameSpace where Base == CGFloat {
    // MARK: - 角度转换成弧度

    /// 角度转换成弧度
    var degreesToRadians: CGFloat {
        return .pi * base / 180.0
    }

    // MARK: - 弧度转换成角度

    /// 弧度转换成角度
    var radiansToDegrees: CGFloat {
        return base * 180 / CGFloat.pi
    }

    // MARK: - 绝对值

    /// 绝对值
    var abs: CGFloat {
        return Swift.abs(base)
    }

    // MARK: - 向上取整，返回的是大于或等于原数,并且与之最接近的整数

    /// 向上取整，返回的是大于或等于原数,并且与之最接近的整数
    var ceil: CGFloat {
        return Foundation.ceil(base)
    }

    // MARK: - 向下取整，它返回的是小于或等于原数,并且与之最接近的整

    /// 向下取整，它返回的是小于或等于原数,并且与之最接近的整数
    var floor: CGFloat {
        return Foundation.floor(base)
    }

    // MARK: - 是否是正数

    /// 是否是正数
    var isPositive: Bool {
        return base > 0
    }

    // MARK: - 是否是负数

    /// 是否是负数
    var isNegative: Bool {
        return base < 0
    }

    // MARK: - 转换为整型

    /// 转换为整型
    var int: Int {
        return Int(base)
    }

    // MARK: - 转换为单精度浮点型

    /// 转换为单精度浮点型
    var float: Float {
        return Float(base)
    }

    // MARK: - 转换为双精度浮点型

    /// 转换为双精度浮点型
    var double: Double {
        return Double(base)
    }
}

//MARK: - 类方法
public extension HMNameSpace where Base == CGFloat {
    // MARK: - 随机数

    /// 随机数
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float.greatestFiniteMagnitude)
    }
}
