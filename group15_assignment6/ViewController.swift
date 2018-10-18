//
//  ViewController.swift
//  group15_assignment6
//
//  Created by Cathy Li on 10/18/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adventurers"
        tableView.register(AdventurerTableViewCell.self,
                           forCellReuseIdentifier: "AdventurerTableViewCell")
        
    }

    @IBAction func addMember(_ sender: UIBarButtonItem) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

