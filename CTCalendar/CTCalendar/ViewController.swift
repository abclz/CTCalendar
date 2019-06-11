//
//  ViewController.swift
//  CTCalendar
//
//  Created by eason on 2019/6/11.
//  Copyright © 2019 普惠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupStyle()
        
        setupFrame()
    }
    
    private func setupStyle() {
        self.view.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 252/255.0, alpha: 1)
        
        //
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        dayList = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.view.addSubview(dayList)
        dayList.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 252/255.0, alpha: 1)
        dayList.dataSource = self
        dayList.delegate = self
        dayList.register(CTCalendarWeekCell.self, forCellWithReuseIdentifier: "CTCalendarWeekCell")
        dayList.register(CTCalendarDayCell.self, forCellWithReuseIdentifier: "CTCalendarDayCell")
        dayList.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        
        
        calendar = CTCalendar(firstDay: firstDay)
        date = Date()
        let nowDate = Date()
        
        // 初始化数据
        for item in 0...11 {
            var calModel = CTCalendarMonthModel()
            date = calendar.getOffsetMonth(date: nowDate, offsetMonths: item)
            calModel = calendar.calculationCalendar(date: date)
            calendarList.append(calModel)
        }
        dayList.reloadData()
    }
    
    private func setupFrame() {
        dayList.frame = CGRect(x: space, y: 105, width: self.view.frame.size.width-space*2, height: UIScreen.main.bounds.size.height-105-40)
        
    }
    
    // MARK: - Private
    // MARK: Prop
    // Control
    /// 日历
    private var dayList: UICollectionView!
    
    /// 月model
    private var calendarMonthModel: CTCalendarMonthModel?
    
    private let firstDay: WeekType = .sun
    /// 日历对象
    private var calendar: CTCalendar!
    /// 日历数组
    private var calendarList: [CTCalendarMonthModel]! = []
    /// 日期
    private var date: Date!
    
    /// 间距
    private let space:CGFloat = 10
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    /// 每个区的item个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 7
        }else {
            let model: CTCalendarMonthModel = calendarList[section-1]
            let totalCount = (model.totalDays)! + (model.lastShowMonthDays)! + (model.nextShowMonthDays)!
            return totalCount
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12+1
    }
    
    /// 自定义cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTCalendarWeekCell", for: indexPath) as! CTCalendarWeekCell
            let index = (firstDay.rawValue - 1 + 6 + indexPath.row+1)%7 + 1
            cell.weekType = WeekType(rawValue: index )!
            return cell
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CTCalendarDayCell", for: indexPath) as! CTCalendarDayCell
            let model: CTCalendarMonthModel = calendarList[indexPath.section-1]
            
            if indexPath.row < model.lastShowMonthDays! {
                // 上个月数据
                let dayModel: CTCalendarDayModel = calendar.offsetMonthDay(date: model.startDate!, index: -(model.lastShowMonthDays! - indexPath.row), currentMonth: false)
                cell.dayModel = dayModel
            } else if (indexPath.row >= model.lastShowMonthDays! && indexPath.row < (model.totalDays! + model.lastShowMonthDays!)){
                // 本月数据
                let dayModel: CTCalendarDayModel = calendar.offsetMonthDay(date: model.startDate!, index:  indexPath.row - model.lastShowMonthDays!, currentMonth: true)
                cell.dayModel = dayModel
            } else {
                // 下月数据
                let dayModel: CTCalendarDayModel = calendar.offsetMonthDay(date: model.endDate!, index:  indexPath.row - model.lastShowMonthDays! - model.totalDays! + 1, currentMonth: false)
                cell.dayModel = dayModel
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header : HeaderCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section != 0 {
                let model: CTCalendarMonthModel = calendarList[indexPath.section-1]
                header.nameString = "\(model.year ?? 0)-\(model.month ?? 0)"
            }
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        }else {
            return CGSize(width: UIScreen.main.bounds.size.width, height: 40)
        }
        
    }
    
    /// 点击cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    /// 最小item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    /// 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: (UIScreen.main.bounds.size.width-space*6-space*2)/7, height: 30)
        }else{
            return CGSize(width: (UIScreen.main.bounds.size.width-space*6-space*2)/7, height: 50)
        }
    }
}
