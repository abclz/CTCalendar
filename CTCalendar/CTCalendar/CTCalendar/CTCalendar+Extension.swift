//
//  CTCalendar+Extension.swift
//  日历
//
//  Created by eason on 2019/4/23.
//  Copyright © 2019 普惠. All rights reserved.
//

import UIKit
// iOS默认的NSDate是格林尼治时间，比中国时区的时间少8个小时
// 1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
enum WeekType: Int {
    case sun    = 1
    case mon    = 2
    case thes   = 3
    case wed    = 4
    case thur   = 5
    case fri    = 6
    case sat    = 7
}

// 星期结构体
struct week {
    let weekType: WeekType
    let weekValue: Int
}

// 阴历月份
struct ChineseCalendarMonth {
    let monthValue: Int
    let monthString: String
}

// 阴历日
struct ChineseCalendarDay {
    let dayValue: Int
    let dayString: String
}

// 阴历节日
struct ChineseFestival {
    let festivalDay: Int
    let festivalMonth: Int
}

// 阳历节日
struct GregorianFestival {
    let festivalDay: Int
    let festivalMonth: Int
}

extension CTCalendar {
    /// 根据date获取日
    func convertDateToDay(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: date)
        return components.day!
    }
    
    /// 根据date获取农历日
    func convertDateToChineseDay(date: Date) -> Int {
        let calendar = Calendar(identifier: .chinese)
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    /// 根据date获取月
    func convertDateToMonth(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.month], from: date)
        return components.month!
    }
    
    /// 根据date获取农历月
    func convertDateToChineseMonth(date: Date) -> Int {
        let calendar = Calendar(identifier: .chinese)
        let components = calendar.dateComponents([.month], from: date)
        return components.month!
    }
    
    /// 根据date获取年
    func convertDateToYear(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year], from: date)
        return components.year!
    }
    
    /// 根据date获取当前周几
    func convertDateToWeekDay(date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second, .weekday], from: date)
        return components.weekday!
    }

    /// 根据date获取当月总天数
    func convertDateToTotalDays(date: Date) -> Int {
        let daysInOfMonth = Calendar.current.range(of: .day, in: .month, for: date)
        let array = Array(daysInOfMonth!)
        return array.count
    }
    
    /// 根据date获取偏移指定天数的date
    func getOffsetDay(date: Date, offsetDays: Int) -> Date {
        let calendar = Calendar.current
        var lastMonthComps = DateComponents()
        lastMonthComps.setValue(offsetDays, for: .day)//year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        let newdate = calendar.date(byAdding: lastMonthComps, to: date)
        return newdate!
    }
    
    /// 根据date获取偏移指定月数的date
    func getOffsetMonth(date: Date, offsetMonths: Int) -> Date {
        let calendar = Calendar.current
        var lastMonthComps = DateComponents()
        lastMonthComps.setValue(offsetMonths, for: .month)////year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        let newdate = calendar.date(byAdding: lastMonthComps, to: date)
        return newdate!
    }
    
    /// 根据date获取偏移指定年数的date
    func getOffsetYear(date: Date, offsetYear: Int) -> Date {
        let calendar = Calendar.current
        var lastMonthComps = DateComponents()
        lastMonthComps.setValue(offsetYear, for: .year)////year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
        let newdate = calendar.date(byAdding: lastMonthComps, to: date)
        return newdate!
    }
    
    /// 获取当前时间
    func currentTime() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        return dateformatter.string(from: Date())
    }
    
    /// date转日期字符串
    func dateConvertString(date: Date, dateFormat: String="yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
    }
    
    /// 日期字符串转date
    func stringConvertDate(string: String, dateFormat: String="yyyy-MM-dd") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    /// 根据日期获取date
    func dateConvertString(year: Int, month: Int, day: Int) -> Date {
        let date = DateComponents(calendar:Calendar.current,timeZone:TimeZone.current, year: year, month: month, day: day)
        return date.date!
    }
    
    /// 当月开始时间
    func startOfCurrentMonth(date: Date) -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: components)
        return startOfMonth!
    }
    
    /// 当月结束时间
    func endOfCurrentMonth(date: Date) -> Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        let endOfMonth = Calendar.current.date(byAdding: components, to: startOfCurrentMonth(date: date))!
        return endOfMonth
    }
}
