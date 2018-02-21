//
//  File.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180215.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class EditSyllabusItemController: UITableViewController {
    
    enum EditItemCellIdentifier: String {
        case nameCell = "nameCell"
        case weightCell = "weightCell"
        case addGradeCell = "addGradeCell"
        case gradeCell = "gradeCell"
    }
    
    var session: Session!
    var course: Course?
    var item: Item?
    
    var oldGrades = [Grade]()
    var newGrades = [Grade]()
    
    
    var store: SessionsStore!
    
    // MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView();
        
        if item != nil {
            self.navigationItem.title = "Edit Syllabus Item"
    }
        
        tableView.delegate = self
    }

    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return newGrades.count + oldGrades.count
            
        case 3:
            return 1
            
        default:
            print("Defaulting when asking for number of rows in section: \(section)")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let identifier = EditItemCellIdentifier.nameCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditItemNameCell
            
            cell.configure(for: item)
            return cell
            
        case 1:
            let identifier = EditItemCellIdentifier.weightCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditItemWeightCell
            
            cell.configure(for: item)
            return cell
            
        case 2:
            let identifier = EditItemCellIdentifier.gradeCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditItemGradeCell
            
            let grade = allGrades()[indexPath.row]
            cell.configure(for: grade)
            return cell
            
        case 3:
            let identifier = EditItemCellIdentifier.addGradeCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditItemAddGradeCell
            
            return cell
            
        default:
            print("Default when asking for cell in section: \(indexPath.section)")
            fatalError()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    // MARK: Actions
    
    
    
    // MARK: Private
    
    // TODO: This is highly inefficient
    
    private func allGrades() -> [Grade] {
        return (oldGrades + newGrades).sorted
            { $0.dateAdded as Date! >= $1.dateAdded! as Date! }
    }
}
