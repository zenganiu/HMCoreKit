//
//  Ex_UIViewFrame.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//
import UIKit

// MARK: - Frame

public extension UIView {
    // MARK: - 原点x轴坐标,用与获取/设置视图原点x轴坐标

    /// 原点x轴坐标,用与获取/设置视图原点x轴坐标
    var hm_x: CGFloat {
        get {
            return frame.origin.x
        } set(value) {
            frame = CGRect(x: value, y: hm_y, width: hm_width, height: hm_height)
        }
    }

    // MARK: - 原点y轴坐标,用与获取/设置视图原点y轴坐标

    /// 原点y轴坐标,用与获取/设置视图原点y轴坐标
    var hm_y: CGFloat {
        get {
            return frame.origin.y
        } set(value) {
            frame = CGRect(x: hm_x, y: value, width: hm_width, height: hm_height)
        }
    }

    // MARK: - 视图宽度，用与获取/设置视图宽度

    /// 视图宽度，用与获取/设置视图宽度
    var hm_width: CGFloat {
        get {
            return frame.size.width
        } set(value) {
            frame = CGRect(x: hm_x, y: hm_y, width: value, height: hm_height)
        }
    }

    // MARK: - 视图高度，用与获取/设置视图宽度

    /// 视图高度，用与获取/设置视图宽度
    var hm_height: CGFloat {
        get {
            return frame.size.height
        } set(value) {
            frame = CGRect(x: hm_x, y: hm_y, width: hm_width, height: value)
        }
    }

    // MARK: - 获取/设置视图在父视图中最左边的x坐标

    /// 获取/设置视图在父视图中最左边的x坐标
    var hm_left: CGFloat {
        get {
            return hm_x
        } set(value) {
            hm_x = value
        }
    }

    // MARK: - 获取/设置视图在父视图中最右边的x坐标

    /// 获取/设置视图在父视图中最右边的x坐标
    var hm_right: CGFloat {
        get {
            return hm_x + hm_width
        } set(value) {
            hm_x = value - hm_width
        }
    }

    // MARK: - 获取/设置视图在父视图中最上边的y坐标

    /// 获取/设置视图在父视图中最上边的y坐标
    var hm_top: CGFloat {
        get {
            return hm_y
        } set(value) {
            hm_y = value
        }
    }

    // MARK: - 获取/设置视图在父视图中最底部的y坐标

    /// 获取/设置视图在父视图中最底部的y坐标
    var hm_bottom: CGFloat {
        get {
            return hm_y + hm_height
        } set(value) {
            hm_y = value - hm_height
        }
    }

    // MARK: - 获取/设置视图的原点坐标

    /// 获取/设置视图的原点坐标
    var hm_origin: CGPoint {
        get {
            return frame.origin
        } set(value) {
            frame = CGRect(origin: value, size: frame.size)
        }
    }

    // MARK: - 获取/设置视图的中心的x坐标

    /// 获取/设置视图的中心的x坐标
    var hm_centerX: CGFloat {
        get {
            return center.x
        } set(value) {
            center.x = value
        }
    }

    // MARK: - 获取/设置视图的中心的y坐标

    /// 获取/设置视图的中心的y坐标
    var hm_centerY: CGFloat {
        get {
            return center.y
        } set(value) {
            center.y = value
        }
    }

    // MARK: - 获取/设置视图的大小

    /// 获取/设置视图的大小
    var hm_size: CGSize {
        get {
            return frame.size
        } set(value) {
            frame = CGRect(origin: frame.origin, size: value)
        }
    }
}
