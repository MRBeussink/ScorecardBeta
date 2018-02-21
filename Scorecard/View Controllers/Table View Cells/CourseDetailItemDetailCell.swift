//
//  CourseDetailItemDetailCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180109.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class CourseDetailItemDetailCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var percentageLabel: UILabel!
}

extension CourseDetailItemDetailCell {
    func configure(for item: Item) {
        
        if let name = item.name {
            titleLabel.text = name
        } else {
            titleLabel.text = "ERROR"
        }
        
        if let percentage = item.percentage {
            percentageLabel.text = formatPercent(from: percentage)
        } else {
            percentageLabel.text = "-- %"
        }
    }
}
