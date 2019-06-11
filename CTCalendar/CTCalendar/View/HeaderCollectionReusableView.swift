//
//  HeaderCollectionReusableView.swift
//  日历
//
//  Created by eason on 2019/6/5.
//  Copyright © 2019 普惠. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    var nameString : String {
        didSet{
            nameLabel.text = nameString
        }
    }
    
    override init(frame: CGRect) {
        nameString = ""
        super.init(frame: frame)
        
        nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.backgroundColor = .lightGray
        nameLabel.font = UIFont.systemFont(ofSize: 25)
        nameLabel.textAlignment = .left
        self.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        nameLabel.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40)
    }
    
    // MARK: - Private
    /// label
    private var nameLabel: UILabel!
}
