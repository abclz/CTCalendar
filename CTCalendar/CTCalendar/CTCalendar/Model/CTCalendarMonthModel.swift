//
//  CTCalendarMonthModel.swift
//  日历
//
//  Created by eason on 2019/4/24.
//  Copyright © 2019 普惠. All rights reserved.
//
//  日历-月model

import UIKit


class CTCalendarMonthModel {
    
    /// 当前年
    var year: Int?
    
    /// 当前月
    var month: Int?
    
    /// 当前日
    var today: Int?
    
    /// 本月第一天
    var startDate: Date?
    
    /// 本月最后一天
    var endDate: Date?
    
    /// 当前月第一天是周几
    var firstWeekDay: WeekType?
    
    /// 当前月最后一天是周几
    var lastWeekDay: WeekType?
    
    /// 当前月的总天数
    var totalDays: Int?
    
    /// 上个月显示的天数
    var lastShowMonthDays: Int?
    
    /// 下个月显示的天数
    var nextShowMonthDays: Int?

}
