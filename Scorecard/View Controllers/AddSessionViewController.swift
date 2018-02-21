//
//  AddSessionViewController.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180104.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import UIKit

class AddSessionViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var store: SessionsStore!
    
    @IBAction func saveNewSession(_ sender: Any) {
        let date = datePicker.date
        store.addNewSession(starting: date)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


