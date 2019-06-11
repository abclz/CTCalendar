//
//  CTCalendarDayModel.swift
//  日历
//
//  Created by eason on 2019/4/24.
//  Copyright © 2019 普惠. All rights reserved.
//
//  日历-日model

import UIKit

class CTCalendarDayModel {
    
    // 当前日期
    var currentDate: Int?
    
    // 当前日期全
    var currentFullDate: Date?
    
    // 当前日期农历-月份
    var currentChineseMonth: ChineseCalendarMonth?
    
    // 当前日期农历-日
    var currentChineseDay: ChineseCalendarDay?
    
    // 是否是本月
    var isCurrentMonth: Bool?
    
    // 周几
    var week: WeekType?
}
