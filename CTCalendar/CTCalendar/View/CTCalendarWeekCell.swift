//
//  CTCalendarWeekCell.swift
//  日历
//
//  Created by eason on 2019/4/22.
//  Copyright © 2019 普惠. All rights reserved.
//
//  日历-星期cell

import UIKit

class CTCalendarWeekCell: UICollectionViewCell {

    var weekType: WeekType {
        didSet {
            switch weekType {
            case .sun:
                weekNameLabel.text = "周日"
            case .mon:
                weekNameLabel.text = "周一"
            case .thes:
                weekNameLabel.text = "周二"
            case .wed:
                weekNameLabel.text = "周三"
            case .thur:
                weekNameLabel.text = "周四"
            case .fri:
                weekNameLabel.text = "周五"
            case .sat:
                weekNameLabel.text = "周六"
            }
        }
    }
    override init(frame: CGRect) {
        weekType = .sun
        super.init(frame: frame)
        self.setupStyle()
        self.setupFrame()
    }
    
    required init?(coder aDecoder: NSCoder) {
        weekType = .sun
        super.init(coder: aDecoder)
        self.setupStyle()
        self.setupFrame()
    }
    
    func setupStyle() {
        weekNameLabel = UILabel()
        weekNameLabel.textColor = UIColor(red: 92/255.0, green: 98/255.0, blue: 117/255.0, alpha: 1)
        weekNameLabel.font = UIFont.systemFont(ofSize: 15)
        weekNameLabel.textAlignment = .center
        self.contentView.addSubview(weekNameLabel)
    }
    
    func setupFrame() {

    }
    
    override func layoutSubviews() {
        weekNameLabel.frame = CGRect(x: 0, y: 5, width: self.frame.size.width, height: 25)
    }
    
    // MARK: - Private
    /// 星期label
    private var weekNameLabel: UILabel!

}
