//
//  CoursesViewController.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180104.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class CoursesViewController: UITableViewController, SegueHandler {
    
    enum SegueIdentifier: String {
        case showCourseDetail = "showCourseDetail"
        case showEditCourse = "showNewCourse"
    }
    
    var store: SessionsStore!
    let coursesDataSource = CoursesDataSource()
    
    var session: Session!
    
   
    
    // MARK: View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        print("Showing courses")
        
        tableView.dataSource = coursesDataSource
        tableView.delegate = self
        
        self.coursesDataSource.store = self.store
        
        navigationItem.title = dateFormatter.string(from: session.startDate!)
        
        store.fetchCourses(for: session) {
            (coursesResult) in
            
            self.updateDataSource()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateDataSource()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segueIdentifier(for: segue) {
        case .showCourseDetail:
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let course = coursesDataSource.courses[selectedIndexPath.row]
                
                print("Showing course detail.")
                
                let courseDetailController = segue.destination as! CourseDetailViewController
                courseDetailController.store = self.store
                courseDetailController.course = course
                courseDetailController.session = self.session
                
            }
            
        case .showEditCourse:
            print("Showing new course.")
            
            let navController = segue.destination as! UINavigationController
            let editController = navController.topViewController as! EditCourseController
            
            editController.store = self.store
            editController.session = self.session
            editController.course = nil
        
        }
    }
    
    // MARK: Actions
    
    @IBAction func addCourse(_ sender: Any) {
        let name = "Test"
        store.addNewCourse(name: name, to: session)
        
        updateDataSource()
    }
    
    
    private func updateDataSource() {
        store.fetchCourses(for: session) {
            (coursesResult) in
            
            switch coursesResult {
            case let .success(courses):
                self.coursesDataSource.courses = courses
                
                // Reload table
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case let .failure(error):
                print("Error updating data source: \(error)")
            }
        }
    }
}
