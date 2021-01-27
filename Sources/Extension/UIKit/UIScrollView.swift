//
//  Ex_UIScrollView.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension HMNameSpace where Base: UIScrollView {
    
    /// 截图
    var snapshot: UIImage? {
        // Original Source: https://gist.github.com/thestoics/1204051
        UIGraphicsBeginImageContextWithOptions(base.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = base.frame
        base.frame = CGRect(origin: base.frame.origin, size: base.contentSize)
        base.layer.render(in: context)
        base.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }

}
