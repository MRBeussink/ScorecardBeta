//
//  CourseDetailDataSource.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180106.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class CourseDetailDataSource: NSObject, UITableViewDataSource {
    
    enum CourseDetailCellIdentifier: String {
        case nameCell = "nameCell"
        case averageCell = "averageCell"
        case itemHeaderCell = "itemHeaderCell"
        case itemDetailCell = "itemDetailCell"
    }
    
    var store = SessionsStore()
    
    var course: Course!
    var items: [Item]!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            if !items.isEmpty {
                return items.count
            } else {
                return 0
            }
        default:
            print("Asking for unknown section \(section).")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
            
        case 0:
            let identifier = CourseDetailCellIdentifier.averageCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CourseDetailAverageCell
            
            cell.configure(for: course)
            return cell
            
        case 1:
            let identifier = CourseDetailCellIdentifier.itemHeaderCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                as! CourseDetailItemHeaderCell
            
            cell.configure(for: course)
            return cell
            
        case 2:
            let identifier = CourseDetailCellIdentifier.itemDetailCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
                as! CourseDetailItemDetailCell
            
            let item = items[indexPath.row]
            
            cell.configure(for: item)
            return cell
            
        default:
            fatalError("Default")
        }
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
}
