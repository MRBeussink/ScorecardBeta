//
//  CourseDetailAverageCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180108.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class CourseDetailAverageCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
}

extension CourseDetailAverageCell {
    func configure(for course: Course) {
        
        self.titleLabel.text = "Average:"
        
        if let average = course.average {
            self.detailLabel.text = formatPercent(from: average)
        } else {
            self.detailLabel.text = "-- %"
        }
    }
}
