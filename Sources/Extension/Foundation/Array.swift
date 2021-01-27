//
//  Ex_Array.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation

public extension Array {
    // MARK: - 获取数组子集

    /// 安全获取数组子集
    /// - Parameter count: 个数
    func hm_safeGet(count: Int) -> Array {
        if count < self.count { return Array(self[0 ..< count]) }
        return Array(self)
    }

    // MARK: - 安全的索引获取元素

    /// 安全的索引获取元素
    /// - Parameter index: 索引
    func hm_safeGet(at index: Int) -> Element? {
        guard index >= 0 && index < count else { return nil }
        return self[index]
    }


    // MARK: - 安全的删除一个元素

    @discardableResult
    mutating func hm_safeRemove(at index: Int) -> Element? {
        if index >= 0, index < count {
            return remove(at: index)
        }
        return nil
    }

    // MARK: - 随机获取一个元素

    /// 随机获取一个元素
    func hm_random() -> Element? {
        guard count > 0 else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
}

public extension Array where Element: Equatable {
    // MARK: - 根据参数去除相同的元素

    /// 根据参数去除相同的元素
    ///   let a = [1,2,3]   let b = [2,3];
    ///   let c = a.difference(b)    [1];
    /// - Parameter values: 数组
    func hm_difference(_ values: [Element]...) -> [Element] {
        var result = [Element]()
        elements: for element in self {
            for value in values {
                //  if a value is in both self and one of the values arrays
                //  jump to the next iteration of the outer loop
                if value.contains(element) {
                    continue elements
                }
            }
            //  element it's only in self
            result.append(element)
        }
        return result
    }

    // MARK: - 并集

    /// 并集
    ///   let a = [1,2,3]   let b = [3,4]
    ///   let c = a.union(b)    [1,2,3,4]
    /// - Parameter values: array
    func hm_union(_ values: [Element]...) -> Array {
        var result = self
        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value)
                }
            }
        }
        return result
    }

    // MARK: - 去除相同元素,返回唯一元素集

    /// 去除相同元素,返回唯一元素集
    /// let b = [1,2,2,3,3].unique   [1,2,3]
    func hm_unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
}

public extension Array where Element: Hashable {
    
    /// 获取指定元素后的一个元素
    /// - Parameter item: 指定元素
    /// - Returns: 新元素
    func hm_after(item: Element) -> Element? {
        if let index = self.firstIndex(of: item), index + 1 < self.count { return self[index + 1] }
        return nil
    }
}
