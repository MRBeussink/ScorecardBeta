//
//  CoursesDataSource.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180104.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class CoursesDataSource: NSObject, UITableViewDataSource {
    
    var courses = [Course]()
    var store: SessionsStore!
    
    func courses(with prefix: String) -> [Course] {
        return courses.filter {
            if let name = $0.name {
                return name.hasPrefix(prefix)
            } else {
                return false;
            }
        }
    }
    
    func course(with name: String) -> [Course] {
        return courses.filter {
            $0.name == name
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Should be \(courses.count) cells.")
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "coursesViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let course = courses[indexPath.row]
        
        cell.textLabel?.text = course.name
        if let average = course.average {
            cell.detailTextLabel?.text = formatPercent(from: average)
        } else {
            cell.detailTextLabel?.text = "-- %"
        }
        print("Returning new cell.")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let courseToDelete = courses[indexPath.row]
        
        store.delete(course: courseToDelete) {
            () in
            
            self.courses.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
