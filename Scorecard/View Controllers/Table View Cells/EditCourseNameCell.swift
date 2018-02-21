//
//  EditCourseNameCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180115.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class EditCourseNameCell: UITableViewCell {
    
    @IBOutlet var nameField: UITextField!
    
}

extension EditCourseNameCell {
    
    func configure(for course: Course?) {
        if let course = course {
            nameField.text = course.name!
        } else {
            nameField.placeholder = "New course"
        }
    }
}
