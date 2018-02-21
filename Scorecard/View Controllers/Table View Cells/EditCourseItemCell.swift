//
//  EditCourseItemCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180120.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class EditCourseItemCell: UITableViewCell {
    
}

extension EditCourseItemCell {
    func configure(for item: Item) {
        
        self.textLabel?.text = item.name
        self.detailTextLabel?.text = formatPercent(from: item.percentage!)
    }
}
