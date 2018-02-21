//
//  NewCourseController.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180114.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class EditCourseController: UITableViewController, SegueHandler {
    
    enum SegueIdentifier: String {
        case showEditItem = "showEditItem"
        case showNewItem = "showNewItem"
    }
    
    enum EditCourseCellIdentifier: String {
        case nameCell = "nameCell"
        case itemHeader = "itemHeader"
        case itemCell = "itemCell"
    }
    
    var course: Course?
    var session: Session!
    
    var newItems = [Item]()
    var oldItems = [Item]()
    

    var store: SessionsStore!
    
    // tableView.cellForRow(at: IndexPath(row: 0, section: 0))
    
    // MARK: View
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        // tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: 0, height: 10)
        
        if course != nil {
            self.navigationItem.title = "Edit Course"
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
            return newItems.count + oldItems.count
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let identifier = EditCourseCellIdentifier.nameCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditCourseNameCell
            
            cell.configure(for: course)
            return cell
            
        case 1:
            let identifier = EditCourseCellIdentifier.itemHeader.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! EditCourseItemHeaderCell
            
            return cell
            
        case 2:
            let identifier = EditCourseCellIdentifier.itemCell.rawValue
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! EditCourseItemCell
            
            let item = allItems()[indexPath.row]
            cell.configure(for: item)
            
            return cell
            
        default:
            fatalError("Cannot return default cell.")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 15
            
        case 1:
            return 0
            
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 30
            
        case 1:
            return 0
            
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifier(for: segue) {
        case .showEditItem:
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let item = allItems()[selectedIndexPath.row]
                
                print("Showing edit item.")
                
                let navController = segue.destination as! UINavigationController
                let editController = navController.topViewController as! EditSyllabusItemController
                
                editController.course = self.course
                editController.session = self.session
                editController.item = item
                editController.store = self.store
            }
            
        case .showNewItem:
            let navController = segue.destination as! UINavigationController
            let addController = navController.topViewController as! EditSyllabusItemController
            
            print("Showing new item.")
            
            addController.course = self.course
            addController.session = self.session
            addController.item = nil
            addController.store = self.store
        }
    }
    
    // MARK: Actions
    
    @IBAction func saveCourse(_ sender: Any) {
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EditCourseNameCell
        
        if var name = nameCell.nameField.text {
            
            if name.isEmpty {
                name = "New course"
            }
            
            if let course = course {
                course.name = name
                
                store.saveStore()
            } else {
                store.addNewCourse(name: name, to: session)
            }
            
        } else {
            let name = "New course"
            store.addNewCourse(name: name, to: session)
        }
        
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelEditing(_ sender: Any) {
        
        // TODO: Create a method isChanged to check if anything has been changed
        
        if !newItems.isEmpty {
            let alertController = UIAlertController(title: "Are you sure?",
                                                    message: "Any unsaved changes will be lost.",
                                                    preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default) { action in
                
                self.saveCourse(self)
            }
            alertController.addAction(saveAction)
            
            let confirmAction = UIAlertAction(title: "Don't save", style: .destructive) { (action) in
                
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(confirmAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            
            
        
        self.present(alertController, animated: true)
        }
        
    }
    
    // MARK: Private
    
    // TODO: This is highly inefficient
    
    private func allItems() -> [Item] {
        return (oldItems + newItems).sorted
            { $0.percentage! as Decimal >= $1.percentage! as Decimal }
    }
}
