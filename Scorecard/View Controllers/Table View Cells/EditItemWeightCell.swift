//
//  EditItemWeightCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180216.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class EditItemWeightCell: UITableViewCell {
    
}

extension EditItemWeightCell {
    
    func configure(for item: Item?) {
        if let item = item {
            if let weight = item.weight {
                self.detailTextLabel?.text = formatPercent(from: weight)
            }
        } else {
            self.detailTextLabel?.text = " -- %"
        }
    }
}
