//
//  Ex_UIFont.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/25.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

/// 字体类型
public enum URFontType: String {
    case None = ""
    case Regular
    case Bold
    case DemiBold
    case Light
    case UltraLight
    case Italic
    case Thin
    case Book
    case Roman
    case Medium
    case MediumItalic
    case CondensedMedium
    case CondensedExtraBold
    case SemiBold
    case BoldItalic
    case Heavy
}

/// 字体名称
public enum URFontName: String {
    case HelveticaNeue
    case Helvetica
    case Futura
    case Menlo
    case Avenir
    case AvenirNext
    case Didot
    case AmericanTypewriter
    case Baskerville
    case Geneva
    case GillSans
    case SanFranciscoDisplay
    case Seravek
}

// MARK: - 初始化方法

public extension HMNameSpace where Base == UIFont {
    static func font(_ name: URFontName, type: URFontType, size: CGFloat) -> UIFont? {
        // Using type
        let fontName = name.rawValue + "-" + type.rawValue
        if let font = UIFont(name: fontName, size: size) {
            return font
        }

        // That font doens't have that type, try .None
        let fontNameNone = name.rawValue
        if let font = UIFont(name: fontNameNone, size: size) {
            return font
        }

        // That font doens't have that type, try .Regular
        let fontNameRegular = name.rawValue + "-" + "Regular"
        if let font = UIFont(name: fontNameRegular, size: size) {
            return font
        }
        return nil
    }
}
