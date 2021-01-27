//
//  Ex_UILabel.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/20.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit.UILabel

public extension HMNameSpace where Base: UILabel {
    /// 获取最佳大小
    func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return base.sizeThatFits(CGSize(width: width, height: height))
    }

    /// 获取最佳高度
    func getEstimatedHeight() -> CGFloat {
        return base.sizeThatFits(CGSize(width: base.hm_width, height: CGFloat.greatestFiniteMagnitude)).height
    }

    /// 获取最佳宽度
    func getEstimatedWidth() -> CGFloat {
        return base.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: base.hm_height)).width
    }
}

public extension UILabel {

    /// 初始化：文本内容、字体大小、颜色、对齐方式
    /// - Parameters:
    ///   - text: 文本内容，默认nil
    ///   - font: 字体大小
    ///   - color: 字体颜色
    ///   - alignment: 对齐方式
    convenience init(text: String? = nil,
                     font: UIFont,
                     color: UIColor,
                     alignment: NSTextAlignment) {
        self.init()
        self.font = font
        textColor = color
        textAlignment = alignment
        self.text = text
    }
    
    
    /// 初始化：文本内容
    /// - Parameter text: 文本内容
    convenience init(text: String?) {
        self.init()
        self.text = text
    }
    
    /// 初始化：文本内容,字体样式
    /// - Parameters:
    ///   - text: 文本内容
    ///   - style: 字体样式
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init()
        font = UIFont.preferredFont(forTextStyle: style)
        self.text = text
    }
}
