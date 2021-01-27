//
//  Ex_UITextField.swift
//  HMCoreKit
//
//  Created by huimin on 2019/10/10.
//  Copyright © 2019 huimin. All rights reserved.
//

import UIKit

public extension UITextField{

    /// 限制字符长度
    /// - Parameter length: 字符长度
    func hm_limitLength(length:Int){
        self.tag = length
        self.addTarget(self, action: #selector(tfDidChange), for: .editingChanged)
    }
    
    @objc private func tfDidChange(textField:UITextField){
        guard let tf = textField.text else { return }
        if tf.count > textField.tag{
            textField.text = textField.text?.hm.subString(start: 0, length: textField.tag)
        }
    }
}
