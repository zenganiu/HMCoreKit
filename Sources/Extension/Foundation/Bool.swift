//
//  Ex_Bool.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/27.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation

extension Bool: HMNameSpaceCompatible {}

public extension HMNameSpace where Base == Bool {
    // MARK: - 转换成数字

    /// 转换成数字:  false.int -> 0；true.int -> 1
    var int: Int {
        return base ? 1 : 0
    }

    // MARK: - 转换成数字

    /// 转换成字符串: false.string -> "false"；true.string -> "true"
    var string: String {
        return base ? "true" : "false"
    }
}
