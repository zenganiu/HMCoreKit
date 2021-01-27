//
//  Ex_CGRect.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/25.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension CGRect {
    /// X轴坐标
    var hm_x: CGFloat {
        get {
            return origin.x
        } set(value) {
            origin.x = value
        }
    }

    /// Y轴坐标
    var hm_y: CGFloat {
        get {
            return origin.y
        } set(value) {
            origin.y = value
        }
    }

    /// 宽度
    var hm_width: CGFloat {
        get {
            return size.width
        } set(value) {
            size.width = value
        }
    }

    /// 高度
    var hm_height: CGFloat {
        get {
            return size.height
        } set(value) {
            size.height = value
        }
    }

    /// 面积
    var hm_area: CGFloat {
        return hm_width * hm_height
    }
}

public extension CGRect {
    @available(iOS, deprecated, renamed: "init(x:y:width:height:)")
    init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }
}
