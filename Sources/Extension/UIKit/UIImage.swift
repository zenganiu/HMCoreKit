//
//  Ex_UIImage.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/26.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

// MARK: - 属性

public extension UIImage {
    /// 图片大小 (字节)
    var hm_bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }

    /// 图片大小 (kb)
    var hm_kilobytesSize: Int {
        return hm_bytesSize / 1024
    }

    /// 始终显示原始图片
    var hm_original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }

    /// 始终显示模板图片
    var hm_template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }

    /// 宽度
    var hm_width: CGFloat {
        return size.width
    }

    /// 高度
    var hm_height: CGFloat {
        return size.height
    }
}

// MARK: - 方法

public extension HMNameSpace where Base: UIImage {
    /// SwifterSwift: Compressed UIImage from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional UIImage (if applicable).
    func compressed(quality: CGFloat = 0.5) -> UIImage? {
        guard let data = compressedData(quality: quality) else { return nil }
        return UIImage(data: data)
    }

    /// SwifterSwift: Compressed UIImage data from original UIImage.
    ///
    /// - Parameter quality: The quality of the resulting JPEG image, expressed as a value from 0.0 to 1.0. The value 0.0 represents the maximum compression (or lowest quality) while the value 1.0 represents the least compression (or best quality), (default is 0.5).
    /// - Returns: optional Data (if applicable).
    func compressedData(quality: CGFloat = 0.5) -> Data? {
        return base.jpegData(compressionQuality: quality)
    }

    /// SwifterSwift: UIImage Cropped to CGRect.
    ///
    /// - Parameter rect: CGRect to crop UIImage to.
    /// - Returns: cropped UIImage
    func cropped(to rect: CGRect) -> UIImage {
        guard rect.size.width <= base.size.width && rect.size.height <= base.size.height else { return base }
        guard let image: CGImage = base.cgImage?.cropping(to: rect) else { return base }
        return UIImage(cgImage: image)
    }

    /// SwifterSwift: UIImage scaled to height with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toHeight: new height.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toHeight: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toHeight / base.size.height
        let newWidth = base.size.width * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, base.scale)
        base.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: UIImage scaled to width with respect to aspect ratio.
    ///
    /// - Parameters:
    ///   - toWidth: new width.
    ///   - opaque: flag indicating whether the bitmap is opaque.
    /// - Returns: optional scaled UIImage (if applicable).
    func scaled(toWidth: CGFloat, opaque: Bool = false) -> UIImage? {
        let scale = toWidth / base.size.width
        let newHeight = base.size.height * scale
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, base.scale)
        base.draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    /// SwifterSwift: Creates a copy of the receiver rotated by the given angle.
    ///
    ///     // Rotate the image by 180°
    ///     image.rotated(by: Measurement(value: 180, unit: .degrees))
    ///
    /// - Parameter angle: The angle measurement by which to rotate the image.
    /// - Returns: A new image rotated by the given angle.
    @available(iOS 10.0, tvOS 10.0, watchOS 3.0, *)
    func rotated(by angle: Measurement<UnitAngle>) -> UIImage? {
        let radians = CGFloat(angle.converted(to: .radians).value)
        let destRect = CGRect(origin: .zero, size: base.size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())
        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)
        base.draw(in: CGRect(origin: CGPoint(x: -base.size.width / 2,
                                             y: -base.size.height / 2),
                             size: base.size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    // MARK: -图片旋转

    /// 图片旋转
    /// - Parameter radians: 弧度
    func rotated(by radians: CGFloat) -> UIImage? {
        let destRect = CGRect(origin: .zero, size: base.size)
            .applying(CGAffineTransform(rotationAngle: radians))
        let roundedDestRect = CGRect(x: destRect.origin.x.rounded(),
                                     y: destRect.origin.y.rounded(),
                                     width: destRect.width.rounded(),
                                     height: destRect.height.rounded())
        UIGraphicsBeginImageContext(roundedDestRect.size)
        guard let contextRef = UIGraphicsGetCurrentContext() else { return nil }
        contextRef.translateBy(x: roundedDestRect.width / 2, y: roundedDestRect.height / 2)
        contextRef.rotate(by: radians)
        base.draw(in: CGRect(origin: CGPoint(x: -base.size.width / 2,
                                             y: -base.size.height / 2),
                             size: base.size))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    // MARK: -设置图片填充色

    /// 设置图片填充色
    /// - Parameter color: 颜色
    func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return base }
        context.translateBy(x: 0, y: base.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        guard let mask = base.cgImage else { return base }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

    // MARK: -设置图片前景色

    /// 设置图片前景色
    /// - Parameter color: 颜色
    /// - Parameter blendMode: 混合模式
    func tint(_ color: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: base.size.width, height: base.size.height)
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.fill(drawRect)
        base.draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

    // MARK: -添加圆角

    /// 添加圆角
    /// - Parameters:
    ///   - radius: 圆角半径；nil为圆形
    /// - Returns: 圆角的UIImage
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(base.size.width, base.size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        let rect = CGRect(origin: .zero, size: base.size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        base.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - 初始化

public extension UIImage {
    // MARK: -通过颜色值创建图片

    /// 通过颜色值创建图片
    /// - Parameters:
    ///   - color: image fill color.
    ///   - size: image size.
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        defer {
            UIGraphicsEndImageContext()
        }
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
}

public extension HMNameSpace where Base == String {
    /// 从资源文件获取图片
    func toImage() -> UIImage? {
        return UIImage(named: base)
    }
}
