//
//  Ex_NSAttributedString.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

//MARK: - 便利初始化方法
public extension NSAttributedString {
    /// 便利初始化方法，字体大小/颜色
    /// - Parameters:
    ///   - string: String
    ///   - font: 字体
    ///   - textColor: 文本颜色
    convenience init(string: String,
                     font: UIFont = .systemFont(ofSize: 17),
                     textColor: UIColor = .black) {
        self.init(string: string,
                  attributes: [NSAttributedString.Key.font: font,
                               NSAttributedString.Key.foregroundColor: textColor]
        )
    }
}

// MARK: - 方法

public extension NSAttributedString {
    // MARK: - 计算富文本的高度

    /// 计算文本的高度： 值会进行向上取整
    /// - Parameter maxWidth: 最大宽度
    /// - Returns: 文本的高度
    func hm_height(maxWidth: CGFloat) -> CGFloat {
        let h = boundingRect(with: .init(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).height
        return ceil(h)
    }

    // MARK: - 计算富文本的宽度

    /// 计算富文本的宽度；值会进行向上取整
    /// - Parameter maxHeight: 最大高度
    /// - Returns: 文本的宽度
    func hm_width(maxHeight: CGFloat) -> CGFloat {
        let w = boundingRect(with: .init(width: CGFloat.greatestFiniteMagnitude, height: maxHeight), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).width
        return ceil(w)
    }

    // MARK: - 添加下划线

    /// 给文本添加下划线
    func hm_underline() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (string as NSString).range(of: string)
        copy.addAttributes([NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue], range: range)
        return copy
    }

    // MARK: - 字体为斜体

    /// 将文本字体设置为斜体
    func hm_italic() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (string as NSString).range(of: string)
        copy.addAttributes([NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        return copy
    }

    func hm_strikethrough() -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (string as NSString).range(of: string)
        let attributes = [
            NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)]
        copy.addAttributes(attributes, range: range)
        return copy
    }

    // MARK: - 字体颜色

    /// 设置文本字体的颜色
    /// - Parameter color: 颜色
    func hm_color(_ color: UIColor) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let range = (string as NSString).range(of: string)
        copy.addAttributes([NSAttributedString.Key.foregroundColor: color], range: range)
        return copy
    }

    // MARK: - 按照ranges，设置对应的attributes

    /// 按照NSRange数组，设置对应的文本attributes
    /// - Parameters:
    ///   - ranges: NSRange数组
    ///   - attributes: [NSAttributedString.Key: Any]
    /// - Returns: 新文本
    func hm_addAttribute(ranges: [NSRange],
                         attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        for range in ranges {
            copy.addAttributes(attributes, range: range)
        }
        return copy
    }
    
    // MARK: - 按照NSRange数组，设置对应文本的字体大小(默认nil)、颜色(默认nil)
    /// 按照NSRange数组，设置对应文本的字体大小(默认nil)、颜色(默认nil)
    /// - Parameters:
    ///   - ranges: NSRange数组
    ///   - font: 字体，默认nil
    ///   - textColor: 文本样式,默认nil
    /// - Returns: 新文本
    func hm_addAttribute(ranges: [NSRange],
                         font: UIFont? = nil,
                         textColor: UIColor? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        return hm_addAttribute(ranges: ranges, attributes: attributes)
    }
    
    
    
    // MARK: - 按照正则，设置对应的attributes

    /// 按照正则，设置对应的attributes
    /// - Parameters:
    ///   - regex: 正则表达式
    ///   - attributes: [NSAttributedString.Key: Any]
    /// - Returns: 新文本
    func hm_addAttribute(regex: String,
                         attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        guard let copy = self.mutableCopy() as? NSMutableAttributedString else { return self }
        let ranges = copy.string.hm.findForRegexInRange(regex)
        for range in ranges {
            copy.addAttributes(attributes, range: range)
        }
        return copy
    }
    
    //MARK: - 按照正则，设置对应文本的字体大小(默认nil)、颜色(默认nil)
    /// 按照正则，设置对应文本的字体大小(默认nil)、颜色(默认nil)
    /// - Parameters:
    ///   - regex: 正则表达式
    ///   - font: 字体，默认nil
    ///   - textColor: 文本样式,默认nil
    /// - Returns: 新文本
    func hm_addAttribute(regex: String,
                         font: UIFont? = nil,
                         textColor: UIColor? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        return hm_addAttribute(regex: regex, attributes: attributes)
        
    }
}
