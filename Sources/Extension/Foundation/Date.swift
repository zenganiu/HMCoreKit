//
//  Ex_Date.swift
//  HMCoreKit
//
//  Created by huimin on 2019/9/24.
//  Copyright © 2019 huimin. All rights reserved.
//

import Foundation

extension Date: HMNameSpaceCompatible {}

// MARK: - 属性

public extension Date {
    // MARK: - 当前日历

    /// 当前日历
    var hm_calendar: Calendar {
        // Workaround to segfault on corelibs foundation https://bugs.swift.org/browse/SR-10147
        return Calendar(identifier: Calendar.current.identifier)
    }

    // MARK: - 时间是否是将来

    /// 时间是否是将来
    var hm_isFuture: Bool {
        return self > Date()
    }

    // MARK: - 时间是否是过去

    /// 时间是否是过去
    var hm_isPast: Bool {
        return self < Date()
    }

    // MARK: - 是否是今天

    /// 是否是今天
    var hm_isToday: Bool {
        return hm_calendar.isDateInToday(self)
    }

    // MARK: - 是否是昨天

    /// 是否是昨天
    var hm_isInYesterday: Bool {
        return hm_calendar.isDateInYesterday(self)
    }

    // MARK: - 是否是明天

    /// 是否是明天
    var hm_isInTomorrow: Bool {
        return hm_calendar.isDateInTomorrow(self)
    }

    // MARK: - 是否是周末

    /// 是否是周末
    var hm_isInWeekend: Bool {
        return hm_calendar.isDateInWeekend(self)
    }

    // MARK: - 是否是在工作日

    /// 是否是在工作日
    var hm_isWorkday: Bool {
        return !hm_calendar.isDateInWeekend(self)
    }

    // MARK: - 是否是在本周内

    /// 是否是在本周内
    var hm_isInCurrentWeek: Bool {
        return hm_calendar.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    // MARK: - 是否是在本月内

    /// 是否是在本月内
    var hm_isInCurrentMonth: Bool {
        return hm_calendar.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    // MARK: - 是否是在本年内

    /// 是否是在本年内
    var hm_isInCurrentYear: Bool {
        return hm_calendar.isDate(self, equalTo: Date(), toGranularity: .year)
    }

    // MARK: -

    /// Date().iso8601String -> "2017-01-12T14:51:29.574Z"
    var hm_iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self).appending("Z")
    }

    // MARK: - 获取世纪

    /// 获取世纪
    var hm_era: Int {
        return Calendar.current.component(Calendar.Component.era, from: self)
    }

    // MARK: - 获取季度

    /// 获取季度
    var hm_quarter: Int {
        let month = Double(hm_calendar.component(.month, from: self))
        let numberOfMonths = Double(hm_calendar.monthSymbols.count)
        let numberOfMonthsInQuarter = numberOfMonths / 4
        return Int(ceil(month / numberOfMonthsInQuarter))
    }

    // MARK: - 设置/获取年份

    /// 设置/获取年份
    var hm_year: Int {
        get {
            return hm_calendar.component(.year, from: self)
        }
        set {
            guard newValue > 0 else { return }
            let currentYear = hm_calendar.component(.year, from: self)
            let yearsToAdd = newValue - currentYear
            if let date = hm_calendar.date(byAdding: .year, value: yearsToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 设置/获取月份

    /// 设置/获取月份
    var hm_month: Int {
        get {
            return hm_calendar.component(.month, from: self)
        }
        set {
            let allowedRange = hm_calendar.range(of: .month, in: .year, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentMonth = hm_calendar.component(.month, from: self)
            let monthsToAdd = newValue - currentMonth
            if let date = hm_calendar.date(byAdding: .month, value: monthsToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 设置/获取是几号

    /// 设置/获取是几号
    var hm_day: Int {
        get {
            return hm_calendar.component(.day, from: self)
        }
        set {
            let allowedRange = hm_calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentDay = hm_calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = hm_calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 获取是星期几

    /// 获取是星期几
    var hm_weekday: Int {
        return hm_calendar.component(.weekday, from: self)
    }

    // MARK: - 设置/获取小时

    /// 设置/获取小时
    var hm_hour: Int {
        get {
            return hm_calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = hm_calendar.range(of: .hour, in: .day, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentHour = hm_calendar.component(.hour, from: self)
            let hoursToAdd = newValue - currentHour
            if let date = hm_calendar.date(byAdding: .hour, value: hoursToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 设置/获取分钟

    /// 设置/获取分钟
    var hm_minute: Int {
        get {
            return hm_calendar.component(.minute, from: self)
        }
        set {
            let allowedRange = hm_calendar.range(of: .minute, in: .hour, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentMinutes = hm_calendar.component(.minute, from: self)
            let minutesToAdd = newValue - currentMinutes
            if let date = hm_calendar.date(byAdding: .minute, value: minutesToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 设置/获取秒

    /// 设置/获取秒
    var hm_second: Int {
        get {
            return hm_calendar.component(.second, from: self)
        }
        set {
            let allowedRange = hm_calendar.range(of: .second, in: .minute, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentSeconds = hm_calendar.component(.second, from: self)
            let secondsToAdd = newValue - currentSeconds
            if let date = hm_calendar.date(byAdding: .second, value: secondsToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 设置/获取纳秒（时间戳）

    /// 设置/获取纳秒（时间戳）
    var hm_nanosecond: Int {
        get {
            return hm_calendar.component(.nanosecond, from: self)
        }
        set {
            let allowedRange = hm_calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(newValue) else { return }
            let currentNanoseconds = hm_calendar.component(.nanosecond, from: self)
            let nanosecondsToAdd = newValue - currentNanoseconds
            if let date = hm_calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: self) {
                self = date
            }
        }
    }

    // MARK: - 设置/获取毫秒

    /// 设置/获取毫秒
    var hm_millisecond: Int {
        get {
            return hm_calendar.component(.nanosecond, from: self) / 1000000
        }
        set {
            let nanoSeconds = newValue * 1000000
            let allowedRange = hm_calendar.range(of: .nanosecond, in: .second, for: self)!
            guard allowedRange.contains(nanoSeconds) else { return }
            if let date = hm_calendar.date(bySetting: .nanosecond, value: nanoSeconds, of: self) {
                self = date
            }
        }
    }

    // MARK: - 改变时间

    /// 改变时间
    /// - Parameters:
    ///   - component: 时间部件
    ///   - value: 跨度
    /// - Returns: 新时间
    func hm_changing(_ component: Calendar.Component, value: Int) -> Date {
        return hm_calendar.date(byAdding: component, value: value, to: self) ?? self
    }
}

// MARK: - 方法

public extension HMNameSpace where Base == Date {
    // MARK: - 转换成字符串时间

    /// 转换成字符串时间
    /// - Parameter format: 时间格式
    func toString(format: String = "YYYY-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = format
        let timeStr = formatter.string(from: base)
        return timeStr
    }

    // MARK: - 毫秒级时间戳

    /// 毫秒级时间戳
    func milliStamp() -> UInt64 {
        return UInt64(base.timeIntervalSince1970 * 1000)
    }

    // MARK: - 秒级时间戳

    /// 秒级时间戳
    func timeStamp() -> UInt64 {
        return UInt64(base.timeIntervalSince1970)
    }

    // MARK: - 改变时间

    func adding(_ component: Calendar.Component, value: Int) -> Date {
        return base.hm_calendar.date(byAdding: component, value: value, to: base)!
    }

    ///     let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///     let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 6:10 PM"
    ///     let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
    ///     let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
    ///     let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date after changing given component to given value.
    func changing(_ component: Calendar.Component, value: Int) -> Date? {
        switch component {
        case .nanosecond:
            let allowedRange = base.hm_calendar.range(of: .nanosecond, in: .second, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentNanoseconds = base.hm_calendar.component(.nanosecond, from: base)
            let nanosecondsToAdd = value - currentNanoseconds
            return base.hm_calendar.date(byAdding: .nanosecond, value: nanosecondsToAdd, to: base)
        case .second:
            let allowedRange = base.hm_calendar.range(of: .second, in: .minute, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentSeconds = base.hm_calendar.component(.second, from: base)
            let secondsToAdd = value - currentSeconds
            return base.hm_calendar.date(byAdding: .second, value: secondsToAdd, to: base)
        case .minute:
            let allowedRange = base.hm_calendar.range(of: .minute, in: .hour, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentMinutes = base.hm_calendar.component(.minute, from: base)
            let minutesToAdd = value - currentMinutes
            return base.hm_calendar.date(byAdding: .minute, value: minutesToAdd, to: base)
        case .hour:
            let allowedRange = base.hm_calendar.range(of: .hour, in: .day, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentHour = base.hm_calendar.component(.hour, from: base)
            let hoursToAdd = value - currentHour
            return base.hm_calendar.date(byAdding: .hour, value: hoursToAdd, to: base)
        case .day:
            let allowedRange = base.hm_calendar.range(of: .day, in: .month, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentDay = base.hm_calendar.component(.day, from: base)
            let daysToAdd = value - currentDay
            return base.hm_calendar.date(byAdding: .day, value: daysToAdd, to: base)
        case .month:
            let allowedRange = base.hm_calendar.range(of: .month, in: .year, for: base)!
            guard allowedRange.contains(value) else { return nil }
            let currentMonth = base.hm_calendar.component(.month, from: base)
            let monthsToAdd = value - currentMonth
            return base.hm_calendar.date(byAdding: .month, value: monthsToAdd, to: base)
        case .year:
            guard value > 0 else { return nil }
            let currentYear = base.hm_calendar.component(.year, from: base)
            let yearsToAdd = value - currentYear
            return base.hm_calendar.date(byAdding: .year, value: yearsToAdd, to: base)
        default:
            return base.hm_calendar.date(bySetting: component, value: value, of: base)
        }
    }
}
