//
//  Ex_UIViewLayer.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/11.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

// MARK: - 图层（圆角、阴影、边框）

public extension UIView {
    // MARK: - 设置圆角

    /// 设置圆角
    /// - Parameter radius: 半径
    func hm_cornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    // MARK: - 添加阴影

    /// 添加阴影
    /// - Parameter offset: 偏移量
    /// - Parameter radius: 阴影半径
    /// - Parameter color: 颜色
    /// - Parameter opacity: 透明度
    /// - Parameter cornerRadius: 圆角半径
    func hm_shadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }

    // MARK: - 添加边框

    /// 添加边框
    /// - Parameter width: 边框宽度
    /// - Parameter color: 边框颜色
    func hm_border(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        layer.masksToBounds = true
    }

    // MARK: - 在边框顶部添加一条线

    /// 在边框顶部添加一条线
    /// - Parameter size: 线宽
    /// - Parameter color: 线颜色
    func hm_borderTop(size: CGFloat, color: UIColor) {
        hm_borderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }

    // MARK: - 在边框顶部添加一条线

    /// 在边框顶部添加一条线
    /// - Parameter size: 线宽
    /// - Parameter color: 线颜色
    /// - Parameter padding: 边距
    func hm_borderTopWithPadding(size: CGFloat, color: UIColor, padding: CGFloat) {
        hm_borderUtility(x: padding, y: 0, width: frame.width - padding * 2, height: size, color: color)
    }

    // MARK: - 在边框底部添加一条线

    /// 在边框底部添加一条线
    /// - Parameter size: 线宽
    /// - Parameter color: 线颜色
    func hm_borderBottom(size: CGFloat, color: UIColor) {
        hm_borderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }

    // MARK: - 在边框左边添加一条线

    /// 在边框左边添加一条线
    /// - Parameter size: 线宽
    /// - Parameter color: 线颜色
    func hm_borderLeft(size: CGFloat, color: UIColor) {
        hm_borderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }

    // MARK: - 在边框右边添加一条线

    /// 在边框右边添加一条线
    /// - Parameter size: 线宽
    /// - Parameter color: 线颜色
    func hm_borderRight(size: CGFloat, color: UIColor) {
        hm_borderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }

    // MARK: - 内部方法，画线

    /// 内部方法
    fileprivate func hm_borderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }

    // MARK: - 矩形框内画圆并填充颜色（起点(0,0),直径等于宽度

    /// 矩形框内画圆并填充颜色（起点(0,0),直径等于宽度）
    /// - Parameter fillColor: 填充颜色
    /// - Parameter strokeColor: 线颜色
    /// - Parameter strokeWidth: 线宽
    func hm_drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: hm_width, height: hm_height), cornerRadius: hm_width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        layer.addSublayer(shapeLayer)
    }

    // MARK: - 矩形框内画圆（起点(0,0),直径等于宽度

    /// 矩形框内画圆（起点(0,0),直径等于宽度）
    /// - Parameter width: 线宽
    /// - Parameter color: 线颜色
    func hm_drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: hm_width, height: hm_width), cornerRadius: hm_width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        layer.addSublayer(shapeLayer)
    }

    // MARK: - 设置圆角(贝塞尔曲线绘制)

    /// 设置圆角(贝塞尔曲线绘制)
    /// - Parameter corners: 圆角位置
    /// - Parameter radius: 半径
    func hm_corners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    // MARK: - 矩形内切的圆

    /// 矩形内切的圆
    /// - Parameter color: 颜色
    /// - Parameter width: 边框宽度
    func hm_roundView(withBorderColor color: UIColor? = nil, withBorderWidth width: CGFloat? = nil) {
        hm_cornerRadius(radius: min(frame.size.height, frame.size.width) / 2)
        layer.borderWidth = width ?? 0
        layer.borderColor = color?.cgColor ?? UIColor.clear.cgColor
    }

    // MARK: - 无遮罩修饰

    /// 无遮罩修饰
    func hm_nakedView() {
        layer.mask = nil
        layer.borderWidth = 0
    }
}
