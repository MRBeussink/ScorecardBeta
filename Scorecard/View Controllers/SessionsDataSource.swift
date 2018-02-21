//
//  SessionsDataSource.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180104.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class SessionsDataSource: NSObject, UITableViewDataSource {
    
    var sessions = [Session]()
    var store = SessionsStore()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Should be \(sessions.count) cells.")
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "sessionsViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        let session = sessions[indexPath.row]
        
        if let startDate = session.startDate {
            let dateText = formatString(from: startDate)
            cell.textLabel?.text = dateText
        } else {
            cell.textLabel?.text = "Error"
        }
        
        print("Returning new cell.")
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let sessionToDelete = sessions[indexPath.row]
        
        store.delete(session: sessionToDelete) {
            () in
            
            self.sessions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
