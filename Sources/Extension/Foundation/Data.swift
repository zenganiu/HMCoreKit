
//
//  Ex_Data.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation
extension Data: HMNameSpaceCompatible {}

// MARK: - 方法

public extension HMNameSpace where Base == Data {
    // MARK: - 根据开始位置和长度截取数据

    /// 根据开始位置和长度截取数据
    /// - Parameter start: 开始位置
    /// - Parameter length: 长度
    func subData(start: Int, length: Int) -> Data {
        let startIndex = base.startIndex.advanced(by: start)
        let endIndex = base.startIndex.advanced(by: start + length)
        return base.subdata(in: Range(uncheckedBounds: (startIndex, endIndex)))
    }

    // MARK: - 转换成字符串

    /// 转换成字符串
    /// - Parameter encoding: 编码方式
    func toString(encoding: String.Encoding = .utf8) -> String? {
        return String(data: base, encoding: .utf8)
    }

    // MARK: - 转换成json

    /// 转换成json
    /// - Parameter options: 解析类型
    func jsonObject(options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: base, options: options)
    }
}
