//
//  Ex_Calendar.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation

extension Calendar: HMNameSpaceCompatible{}
extension HMNameSpace where Base == Calendar{
    
    /// SwifterSwift: Return the number of days in the month for a specified 'Date'.
    ///
    ///        let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///        Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    func numberOfDaysInMonth(for date: Date) -> Int {
        return base.range(of: .day, in: .month, for: date)!.count
    }
}

