//
//  CTCalendar.swift
//  日历
//
//  Created by eason on 2019/4/22.
//  Copyright © 2019 普惠. All rights reserved.
//
//  自定义日历组件

import UIKit

class CTCalendar {
    // MARK: - Public
    public var calendarMonth: CTCalendarMonthModel!

    // 阴历日
    var chineseCalendarDayArray: [ChineseCalendarDay] = [
        ChineseCalendarDay(dayValue: 1, dayString: "初一"),
        ChineseCalendarDay(dayValue: 2, dayString: "初二"),
        ChineseCalendarDay(dayValue: 3, dayString: "初三"),
        ChineseCalendarDay(dayValue: 4, dayString: "初四"),
        ChineseCalendarDay(dayValue: 5, dayString: "初五"),
        ChineseCalendarDay(dayValue: 6, dayString: "初六"),
        ChineseCalendarDay(dayValue: 7, dayString: "初七"),
        ChineseCalendarDay(dayValue: 8, dayString: "初八"),
        ChineseCalendarDay(dayValue: 9, dayString: "初九"),
        ChineseCalendarDay(dayValue: 10, dayString: "初十"),
        ChineseCalendarDay(dayValue: 11, dayString: "十一"),
        ChineseCalendarDay(dayValue: 12, dayString: "十二"),
        ChineseCalendarDay(dayValue: 13, dayString: "十三"),
        ChineseCalendarDay(dayValue: 14, dayString: "十四"),
        ChineseCalendarDay(dayValue: 15, dayString: "十五"),
        ChineseCalendarDay(dayValue: 16, dayString: "十六"),
        ChineseCalendarDay(dayValue: 17, dayString: "十七"),
        ChineseCalendarDay(dayValue: 18, dayString: "十八"),
        ChineseCalendarDay(dayValue: 19, dayString: "十九"),
        ChineseCalendarDay(dayValue: 20, dayString: "二十"),
        ChineseCalendarDay(dayValue: 21, dayString: "廿一"),
        ChineseCalendarDay(dayValue: 22, dayString: "廿二"),
        ChineseCalendarDay(dayValue: 23, dayString: "廿三"),
        ChineseCalendarDay(dayValue: 24, dayString: "廿四"),
        ChineseCalendarDay(dayValue: 25, dayString: "廿五"),
        ChineseCalendarDay(dayValue: 26, dayString: "廿六"),
        ChineseCalendarDay(dayValue: 27, dayString: "廿七"),
        ChineseCalendarDay(dayValue: 28, dayString: "廿八"),
        ChineseCalendarDay(dayValue: 29, dayString: "廿九"),
        ChineseCalendarDay(dayValue: 30, dayString: "三十"),
    ]
    // 阴历月
    var chineseCalendarMonthArray: [ChineseCalendarMonth] = [
        ChineseCalendarMonth(monthValue: 1, monthString: "正月"),
        ChineseCalendarMonth(monthValue: 2, monthString: "二月"),
        ChineseCalendarMonth(monthValue: 3, monthString: "三月"),
        ChineseCalendarMonth(monthValue: 4, monthString: "四月"),
        ChineseCalendarMonth(monthValue: 5, monthString: "五月"),
        ChineseCalendarMonth(monthValue: 6, monthString: "六月"),
        ChineseCalendarMonth(monthValue: 7, monthString: "七月"),
        ChineseCalendarMonth(monthValue: 8, monthString: "八月"),
        ChineseCalendarMonth(monthValue: 9, monthString: "九月"),
        ChineseCalendarMonth(monthValue: 10, monthString: "十月"),
        ChineseCalendarMonth(monthValue: 11, monthString: "十一月"),
        ChineseCalendarMonth(monthValue: 12, monthString: "十二月"),
    ]
    
    init(firstDay: WeekType = .sun) {
        firstLineOfMonth = firstDay
        lastLineOfMonth = WeekType(rawValue: (firstLineOfMonth.rawValue-1+6)%7+1)
    }
    
    // 计算日历，date为date类型
    func calculationCalendar(date: Date) -> CTCalendarMonthModel {
        // 获取第一天时间
        let startDate = self.startOfCurrentMonth(date: date)
        // 获取最后一天时间
        let endDate = self.endOfCurrentMonth(date: date)
        calendarMonth = CTCalendarMonthModel()
        calendarMonth.startDate = self.startOfCurrentMonth(date: date)
        calendarMonth.endDate = self.endOfCurrentMonth(date: date)
        calendarMonth.year = self.convertDateToYear(date: startDate)
        calendarMonth.month = self.convertDateToMonth(date: startDate)
        calendarMonth.today = self.convertDateToDay(date: startDate)
        calendarMonth.firstWeekDay = WeekType(rawValue: self.convertDateToWeekDay(date: startDate))
        calendarMonth.lastWeekDay = WeekType(rawValue: self.convertDateToWeekDay(date: endDate))
        calendarMonth.totalDays = self.convertDateToTotalDays(date: startDate)
        calendarMonth.lastShowMonthDays = (calendarMonth.firstWeekDay!.rawValue - firstLineOfMonth.rawValue + 7)%7
        calendarMonth.nextShowMonthDays = (lastLineOfMonth.rawValue - calendarMonth.lastWeekDay!.rawValue + 7)%7
        return calendarMonth
    }
    
    /// 根据偏移量计算day
    func offsetMonthDay(date: Date, index: Int, currentMonth: Bool) -> CTCalendarDayModel {
        let calendarDay = CTCalendarDayModel()
        let nextDate = self.getOffsetDay(date: date, offsetDays: index)
        calendarDay.currentFullDate = nextDate
        calendarDay.currentDate = self.convertDateToDay(date: nextDate)
        calendarDay.isCurrentMonth = currentMonth
        calendarDay.week = WeekType(rawValue: self.convertDateToWeekDay(date: nextDate))
        calendarDay.currentChineseDay = self.chineseCalendarDayArray[self.convertDateToChineseDay(date: nextDate)-1]
        calendarDay.currentChineseMonth = self.chineseCalendarMonthArray[self.convertDateToChineseMonth(date: nextDate)-1]
        return calendarDay
    }
    
    private let firstLineOfMonth: WeekType! // 每月第一行是周几
    private let lastLineOfMonth: WeekType!  // 每月最后一行是周几
}


