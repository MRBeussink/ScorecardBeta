//
//  ViewController.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180104.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class SessionsViewController: UITableViewController, SegueHandler {

    enum SegueIdentifier: String {
        case showAddSession = "showAddSession"
        case showCourses = "showCourses"
    }
    
    var store: SessionsStore!
    let sessionsDataSource = SessionsDataSource()
    
    
    // MARK: View methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        tableView.dataSource = sessionsDataSource
        tableView.delegate = self
        
        self.sessionsDataSource.store = self.store
        
        updateDataSource()
       
        store.fetchAllSessions {
            (sessionsResult) in
            
            self.updateDataSource()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear.")
        self.updateDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .showAddSession:
            let navController = segue.destination as! UINavigationController
            let addController = navController.topViewController as! AddSessionViewController
            
            addController.store = self.store
            
        case .showCourses:
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let session = sessionsDataSource.sessions[selectedIndexPath.row]
                
                print("Showing courses for semester.")
                
                let coursesController = segue.destination as! CoursesViewController
                coursesController.store = self.store
                coursesController.session = session
                
            }
            
        }
    }
    
    // MARK: Private
    
    private func updateDataSource() {
        store.fetchAllSessions {
            (sessionsResult) in
            
            switch sessionsResult  {
            case let .success(sessions):
                print("Loaded \(sessions.count) sessions")
                self.sessionsDataSource.sessions = sessions
                
                // REFACTOR THIS!!! (maybe?)
                print("Reloading sections.")
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            case let .failure(error):
                print("Error updating data source: \(error)")
            }
        }
        
        
    }
    
}

