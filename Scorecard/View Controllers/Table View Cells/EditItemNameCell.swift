//
//  EditItemNameCell.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180216.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit
    
class EditItemNameCell: UITableViewCell {
    
    @IBOutlet var nameField: UITextField!
}

extension EditItemNameCell {
    
    func configure(for item: Item?) {
        if let item = item {
            nameField.text = item.name!
        } else {
            nameField.placeholder = "New item"
        }
    }
}
