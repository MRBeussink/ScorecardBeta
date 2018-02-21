//
//  EditItemGradeCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180216.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class EditItemGradeCell: UITableViewCell {
    
}

extension EditItemGradeCell {
    func configure(for grade: Grade?) {
        if let grade = grade {
            self.textLabel?.text = grade.name!
            self.detailTextLabel?.text = formatPercent(from: grade.score!)
        } else {
            self.textLabel?.text = "Error"
        }
    }
}
