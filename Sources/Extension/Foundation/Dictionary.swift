//
//  Ex_Dictionary.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation

public extension Dictionary {
    // MARK: - 随机返回一个value

    /// 随机返回一个value
    func hm_random() -> Value? {
        return Array(values).hm_random()
    }

    // MARK: - 合并两个字典，

    /// 合并两个字典
    func hm_union(_ dictionaries: Dictionary...) -> Dictionary {
        var result = self
        dictionaries.forEach { (dictionary) -> Void in
            dictionary.forEach { (key, value) -> Void in
                result[key] = value
            }
        }
        return result
    }

    // MARK: - 字典是否含有指定的key

    /// 字典是否含有指定的key
    func hm_has(_ key: Key) -> Bool {
        return index(forKey: key) != nil
    }

    // MARK: - 转换为数组

    /// 转换为数组
    func hm_toArray<V>(_ map: (Key, Value) -> V) -> [V] {
        return self.map(map)
    }

    // MARK: - 过滤字典

    /// 过滤字典
    func hm_filter(_ test: (Key, Value) -> Bool) -> Dictionary {
        var result = Dictionary()
        for (key, value) in self {
            if test(key, value) {
                result[key] = value
            }
        }
        return result
    }
}

public extension Dictionary where Value: Equatable {
    func hm_difference(_ dictionaries: [Key: Value]...) -> [Key: Value] {
        var result = self
        for dictionary in dictionaries {
            for (key, value) in dictionary {
                if result.hm_has(key) && result[key] == value {
                    result.removeValue(forKey: key)
                }
            }
        }
        return result
    }
}

public extension Dictionary where Key: Equatable {
    // MARK: - 拼接字典，相同key将覆盖
    /// 拼接字典，相同key将覆盖
    func hm_append(_ dict: [Key: Value]) -> [Key: Value] {
        var result = self
        for (k, v) in dict {
            result[k] = v
        }
        return result
    }
}
