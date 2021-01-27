//
//  Ex_String.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//
import CommonCrypto
import Foundation
import UIKit

extension String: HMNameSpaceCompatible {}

// MARK: - 属性

public extension HMNameSpace where Base == String {
    // MARK: - base64解密

    /// base64解密
    var base64Decoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        guard let decodedData = Data(base64Encoded: self.base) else { return nil }
        return String(data: decodedData, encoding: .utf8)
    }

    // MARK: - base64加密

    /// base64加密
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = base.data(using: .utf8)
        return plainData?.base64EncodedString()
    }

    // MARK: - 内容转换为驼峰

    /// 内容转换为驼峰
    var camelCased: String {
        let source = base.lowercased()
        let first = source[..<source.index(after: source.startIndex)]
        if source.contains(" ") {
            let connected = source.capitalized.replacingOccurrences(of: " ", with: "")
            let camel = connected.replacingOccurrences(of: "\n", with: "")
            let rest = String(camel.dropFirst())
            return first + rest
        }
        let rest = String(source.dropFirst())
        return first + rest
    }

    // MARK: - 是否有效的URL

    /// 是否有效的URL
    var isValidUrl: Bool {
        return URL(string: base) != nil
    }

    // MARK: - 是否是有效的https

    /// 是否是有效的https
    var isValidHttpsUrl: Bool {
        guard let url = URL(string: self.base) else { return false }
        return url.scheme == "https"
    }

    // MARK: - 是否是有效的http

    /// 是否是有效的http
    var isValidHttpUrl: Bool {
        guard let url = URL(string: self.base) else { return false }
        return url.scheme == "http"
    }

    // MARK: - 是否是有效的文件路径

    /// 是否是有效的文件路径
    var isValidFileUrl: Bool {
        return URL(string: base)?.isFileURL ?? false
    }

    // MARK: - 移除所有的空格和换行符

    /// 移除所有的空格和换行符
    var withoutSpacesAndNewLines: String {
        return base.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
    }

    // MARK: - 字符串长度

    /// 字符串长度
    var length: Int {
        let str = base as NSString
        return str.length
    }

    // MARK: - 转换为URL

    /// 转换为URL
    var url: URL? {
        return URL(string: base)
    }

    // MARK: - 是否是数字

    /// 是否是数字
    var isNumber: Bool {
        return NumberFormatter().number(from: base) != nil ? true : false
    }

    // MARK: - 转换为整型

    /// 转换为整型
    var int: Int? {
        if let num = NumberFormatter().number(from: self.base) {
            return num.intValue
        } else {
            return nil
        }
    }

    /// 转换为整型, 默认为0
    var intValue: Int {
        int ?? 0
    }

    // MARK: - 转换为浮点数

    /// 转换为浮点数
    var float: Float? {
        if let num = NumberFormatter().number(from: self.base) {
            return num.floatValue
        } else {
            return nil
        }
    }

    var floatValue: Float {
        return float ?? 0
    }

    // MARK: - 转换为双精度浮点数

    /// 转换为双精度浮点数
    var double: Double? {
        if let num = NumberFormatter().number(from: self.base) {
            return num.doubleValue
        } else {
            return nil
        }
    }

    var doubleValue: Double {
        return double ?? 0
    }

    // MARK: - 转换为无符号64位整数

    /// 转换为无符号64位整数
    var uInt64: UInt64? {
        if let num = NumberFormatter().number(from: self.base) {
            return num.uint64Value
        } else {
            return nil
        }
    }

    var uInt64Value: UInt64 {
        return uInt64 ?? 0
    }

    // MARK: - 转为Bool

    /// 转为Bool
    var bool: Bool? {
        let trimmedString = base.lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    var boolValue: Bool {
        return bool ?? false
    }

    // MARK: - 16进制转10进制

    /// 16进制转10进制
    var hexToInt: Int {
        let str = base.uppercased()
        var sum = 0
        for i in str.utf8 {
            sum = sum * 16 + Int(i) - 48 // 0-9从48开始
            if i >= 65 {
                sum -= 7 // A-Z 从65开始
            }
        }
        return sum
    }

    // MARK: - 汉字转拼音

    /// 汉字转拼音
    var toPinYin: String {
        let mStr = NSMutableString(string: base)
        CFStringTransform(mStr, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mStr, nil, kCFStringTransformStripDiacritics, false)
        let str = String(mStr).replacingOccurrences(of: " ", with: "")
        return str
    }

    // MARK: - 转换为NSString

    /// 转换为NSString
    var nsString: NSString { return base as NSString }

    // MARK: - URL解码

    /// URL解码
    var urlDecoded: String {
        return base.removingPercentEncoding ?? base
    }

    // MARK: - URL编码

    /// URL编码
    var urlEncoded: String {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    // MARK: - 转换为NSAttributedString

    /// 转换为NSAttributedString
    var attributedString: NSAttributedString {
        return NSAttributedString(string: base)
    }

    /// 是否是手机号码
    var isMobilePhone: Bool {
        let pattern = "^1[3456789]\\d{9}$"
        return regex(pattern: pattern)
    }

    /// 是否是邮箱号码
    var isEmail: Bool {
        let pattern = "^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$"
        return regex(pattern: pattern)
    }

    /// 是否是链接
    var isLink: Bool {
        let pattern = "^((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
        return regex(pattern: pattern)
    }
    
    /// URL参数转化成字典
    var queryParameters: [String: String]? {
        
        let params = self.base.removingPercentEncoding ?? ""
        let url = URL(string: "https://www.apple.com/query?\(params)")!

        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let queryItems = components.queryItems else {
            return nil
        }

        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }

        return parameters
    }
    
}

// MARK: - 方法

public extension HMNameSpace where Base == String {
    // MARK: - 根据开始位置和长度截取字符串

    /// 根据开始位置和长度截取字符串
    /// - Parameters:
    ///   - start: 开始位置
    ///   - length: 长度
    /// - Returns: 截取的字符串
    func subString(start: Int, length: Int = -1) -> String {
        let len = length
        var range: Range<String.Index> = base.startIndex ..< base.endIndex
        // 起始位置小于0；不处理
        if start < 0 {
            return String(base[range])
        }
        guard let startIdx = self.base.index(base.startIndex, offsetBy: start, limitedBy: base.endIndex) else {
            return String(base[range])
        }
        if len < 0 {
            range = startIdx ..< base.endIndex
            return String(base[range])
        }
        guard let endIdx = self.base.index(startIdx, offsetBy: len, limitedBy: base.endIndex) else {
            range = startIdx ..< base.endIndex
            return String(base[range])
        }
        range = startIdx ..< endIdx
        return String(base[range])
    }

    // MARK: - 字符串时间转换成Date 默认yyyy-MM-dd HH:mm:ss

    /// 字符串时间转换成Date 默认yyyy-MM-dd HH:mm:ss
    /// - Parameter format: 格式化样式  默认yyyy-MM-dd HH:mm:ss
    /// - Returns: Date
    func toDate(format: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "zh_CN")
        let date = formatter.date(from: base)
        return date
    }

    // MARK: - md5加密

    /// md5加密
    /// - Parameter digit: 字符位数；默认16位
    func md5(digit: Int = 16) -> String {
        guard let cStr = self.base.cString(using: .utf8) else {
            return ""
        }
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: digit)
        CC_MD5(cStr, CC_LONG(strlen(cStr)), buffer)
        var md5Str = String()
        for i in 0 ..< digit {
            md5Str += String(format: "%02x", buffer[i])
        }
        free(buffer)
        return md5Str
    }

    // MARK: - 正则查找符合的子串，并返回所有符合的子串数组

    /// 正则查找符合的子串，并返回所有符合的子串数组
    /// - Parameter regex: 正则表达式
    func findForRegexInText(_ regex: String) -> [String] {
        let regular = try? NSRegularExpression(pattern: regex, options: [])
        let results = regular?.matches(in: base, options: [], range: NSRange(location: 0, length: length)) ?? []
        return results.map { self.subString(start: $0.range.location, length: $0.range.length) }
    }

    // MARK: - 正则查找符合的子串，并返回所有符合的子串位置

    /// 正则查找符合的子串，并返回所有符合的子串位置
    /// - Parameter regex: 正则表达式
    func findForRegexInRange(_ regex: String) -> [NSRange] {
        let regular = try? NSRegularExpression(pattern: regex, options: [])
        let results = regular?.matches(in: base, options: [], range: NSRange(location: 0, length: length)) ?? []
        return results.map { $0.range }
    }

    // MARK: - 正则是否匹配

    /// 正则是否匹配
    /// - Parameter pattern: 正则表达式
    func regex(pattern: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let matches = regex.matches(in: base, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, base.count))
            return matches.count > 0
        } catch {
            return false
        }
    }

    // MARK: - 正则替换

    func findForRegexAndReplace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        do {
            let regular = try NSRegularExpression(pattern: pattern, options: options)
            return regular.stringByReplacingMatches(in: base, options: [], range: NSRange(location: 0, length: length), withTemplate: with)
        } catch {
            return with
        }
    }

    // MARK: - 从bundle中获取图片;默认nil,从主工程中获取

    /// 从bundle中获取图片
    func toImageFromBundle(aclass: AnyClass.Type? = nil) -> UIImage? {
        var bundle = Bundle.main
        if let cla = aclass {
            bundle = Bundle(for: cla)
        }
        return UIImage(named: base, in: bundle, compatibleWith: nil)
    }

    // MARK: - 指定宽度,获取高度

    /// 指定宽度,获取高度
    func height(maxWidth: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let str = base as NSString
        let size = str.boundingRect(with: .init(width: maxWidth, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return size.height
    }

    /// 获取字符串所在的高度
    /// - Parameters:
    ///   - maxWidth: 限定的宽度
    ///   - font: 字体
    func height(maxWidth: CGFloat, font: UIFont) -> CGFloat {
        return height(maxWidth: maxWidth, attributes: [NSAttributedString.Key.font: font])
    }

    // MARK: - 指定高度,获取宽度

    /// 指定宽度,获取高度
    func width(maxHeight: CGFloat, attributes: [NSAttributedString.Key: Any]) -> CGFloat {
        let str = base as NSString
        let size = str.boundingRect(with: .init(width: .greatestFiniteMagnitude, height: maxHeight), options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return size.width
    }

    /// 获取字符串所在的宽度
    /// - Parameters:
    ///   - maxHeight: 限定的高度
    ///   - font: 字体
    func width(maxHeight: CGFloat, font: UIFont) -> CGFloat {
        return width(maxHeight: maxHeight, attributes: [NSAttributedString.Key.font: font])
    }
}
