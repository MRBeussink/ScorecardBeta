//
//  CourseDetailNameCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180108.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class CourseDetailNameCell: UITableViewCell {
    
    @IBOutlet weak var nameField: UITextField!
    
}

extension CourseDetailNameCell {
    func configure(for course: Course) {
        
        if let name = course.name {
            nameField.text = name
        } else {
            nameField.text = "TEST"
        }
    }
}
