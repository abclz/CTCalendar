//
//  CTCalendarDayCell.swift
//  日历
//
//  Created by eason on 2019/4/22.
//  Copyright © 2019 普惠. All rights reserved.
//
//  日历-日cell

import UIKit

class CTCalendarDayCell: UICollectionViewCell {

    var dayModel: CTCalendarDayModel? {
        didSet {
            dayNameLabel.text = "\(dayModel?.currentDate ?? 0)"
            if dayModel?.currentChineseDay?.dayString == "初一" {
                contentLabel.text = dayModel?.currentChineseMonth?.monthString
            }else {
                contentLabel.text = dayModel?.currentChineseDay?.dayString
            }
            
            dayNameLabel.textColor = UIColor.black
            contentLabel.textColor = UIColor(red: 92/255.0, green: 98/255.0, blue: 117/255.0, alpha: 1)
            
            if dayModel?.week == .sun || dayModel?.week == .sat {
                contentLabel.textColor = UIColor.red
                dayNameLabel.textColor = UIColor.red
            }
            
            if dayModel?.isCurrentMonth == false {
                contentLabel.textColor = UIColor.lightGray
                dayNameLabel.textColor = UIColor.lightGray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupStyle()
        self.setupFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupStyle()
        self.setupFrame()
        
    }
    
    func setupStyle() {
        dayNameLabel = UILabel()
        dayNameLabel.font = UIFont.systemFont(ofSize: 20)
        dayNameLabel.textAlignment = .center
        self.contentView.addSubview(dayNameLabel)
        
        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textAlignment = .center
        self.contentView.addSubview(contentLabel)
    }
    
    func setupFrame() {
        
    }
    
    override func layoutSubviews() {
        dayNameLabel.frame = CGRect(x: 0, y: 5, width: self.frame.size.width, height: 20)
        contentLabel.frame = CGRect(x: 0, y: 30, width: self.frame.size.width, height: 15)
    }
    
    // MARK: - Private
    /// 日label
    private var dayNameLabel: UILabel!
    /// 描述label（可以是节日或者阴历）
    private var contentLabel: UILabel!
}
