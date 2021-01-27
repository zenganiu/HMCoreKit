//
//  UIEdgeInsets.swift
//  HMCoreKit
//
//  Created by huimin on 2020/3/11.
//  Copyright © 2020 huimin. All rights reserved.
//

import UIKit

extension UIEdgeInsets{
    ///设置相同的偏移量
    init(all: CGFloat){
        self.init(top: all, left: all, bottom: all, right: all)
    }
}
