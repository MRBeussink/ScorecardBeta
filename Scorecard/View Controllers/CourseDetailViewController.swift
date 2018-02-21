//
//  CourseDetailViewController.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180106.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit
import CoreData

class CourseDetailViewController: UITableViewController, SegueHandler {
    
    typealias Items = [Item]
    
    enum SegueIdentifier: String {
        // case showItemDetail = "showItemDetail"
        case showEditCourse = "showEditCourse"
    }
    
    var store: SessionsStore!
    let courseDetailDataSource = CourseDetailDataSource()
    
    var course: Course!
    var session: Session!
    
    // MARK: View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        print("Showing course detail.")
        
        tableView.dataSource = courseDetailDataSource
        tableView.delegate = self
        
        if self.course == nil {
            self.createNewCourse()
        }
        
        self.courseDetailDataSource.store = store
        self.courseDetailDataSource.course = self.course
        self.courseDetailDataSource.items = Items()
        
        if let name = course.name {
            navigationItem.title = name
        } else {
            navigationItem.title = "ERROR"
            
        }
        
        
        store.fetchItems(for: course) {
            (itemsResult) in
            
            self.updateDataSource()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let name = course.name {
            navigationItem.title = name
        } else {
            navigationItem.title = "ERROR"
            
        }
        
        self.updateDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifier(for: segue) {
        case .showEditCourse:
            let navController = segue.destination as! UINavigationController
            let editController = navController.topViewController as! EditCourseController
            
            editController.store = self.store
            editController.session = self.session
            editController.course = self.course
        }
    }
    
    // MARK: Actions
    
    @IBAction func showMoreOptions(_ sender: Any) {
        
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) in
            // do nothing
        }
        alertController.addAction(cancelAction)
        
        let renameAction = UIAlertAction(title: "Rename course", style: .default) {
            (action) in
            
            self.renameCourse()
        }
        alertController.addAction(renameAction)
        
        let deleteAction = UIAlertAction(title: "Delete course", style: .destructive) {
            (action) in
            
            self.deleteCourse()
        }
        alertController.addAction(deleteAction)
        
        self.present(alertController, animated: true)
    }
    
    // MARK: Private
    
    private func updateDataSource() {
        store.fetchItems(for: course) {
            (itemsResult) in
            
            switch itemsResult {
            case let .success(items):
                self.courseDetailDataSource.items = items
                
                self.tableView.reloadData()
            case let .failure(error):
                print("Error updating data source: \(error)")
            }
        }
    }
    
    private func renameCourse() {
        // present alert
        
        
    }
    
    private func deleteCourse() {
        
    }
    
    // MARK: Delete
    
    private func createNewCourse() {
        let alertController = UIAlertController(title: "New Course",
                                               message: "Name",
                                               preferredStyle: .alert)
        
        alertController.addTextField {
            (textField) -> Void in
            textField.placeholder = "course name"
            textField.autocapitalizationType = .words
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (action) -> Void in
            
            if let courseName = alertController.textFields?.first?.text {
                let context = self.store.persistentContainer.viewContext
                let newCourse = NSEntityDescription.insertNewObject(forEntityName: "Course", into: context)
                
                newCourse.setValue(courseName, forKey: "name")
                
                do {
                    try self.store.persistentContainer.viewContext.save()
                } catch let error {
                    print("Core Data save failed: \(error)")
                }
                
                self.navigationItem.title = self.course.name!
                
                self.updateDataSource()
            }
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (action) -> Void in
            
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
