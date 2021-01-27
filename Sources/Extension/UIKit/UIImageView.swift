//
//  Ex_UIImageView.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//
import UIKit

extension HMNameSpace where Base == UIImageView {
    // MARK: - 下载图片

    /// 下载图片
    /// - Parameter url: url
    /// - Parameter contentMode: 显示方式
    /// - Parameter placeholder: 占位图
    /// - Parameter completionHandler: 完成后回调
    func download(
        from url: URL,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        placeholder: UIImage? = nil,
        completionHandler: ((UIImage?) -> Void)? = nil) {
        base.image = placeholder
        base.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
            else {
                completionHandler?(nil)
                return
            }
            DispatchQueue.main.async {
                self.base.image = image
                completionHandler?(image)
            }
        }.resume()
    }

    // MARK: - 模糊

    /// 模糊
    /// - Parameter style: 风格
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = base.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        base.addSubview(blurEffectView)
        base.clipsToBounds = true
    }

    // MARK: - 获取模糊图片

    /// 获取模糊图片
    /// - Parameter style: 风格
    @discardableResult
    func blurred(withStyle style: UIBlurEffect.Style = .light) -> UIImageView {
        let imgView = base
        imgView.hm.blur(withStyle: style)
        return imgView
    }
}

public extension UIImageView {
    /// 便利初始化方法
    /// - Parameters:
    ///   - aImage: UIImage
    ///   - mode: 显示方式，默认scaleAspectFill
    convenience init(aImage: UIImage?, mode: UIView.ContentMode = .scaleAspectFill) {
        self.init(image: aImage)
        image = image
        contentMode = mode
    }
}
