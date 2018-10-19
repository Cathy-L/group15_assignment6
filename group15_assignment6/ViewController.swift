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
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        
    }

    @IBAction func addMember(_ sender: UIBarButtonItem) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    //func numberOfSections(in tableView: UITableView) -> Int {
    //    return 1
    //}
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let cellIdentifier = "AdventurerTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AdventurerTableViewCell
            cell.name?.text = "Name"
            cell.level?.text = "0"
            cell.profession?.text = "Profession"
            cell.attack?.text = "0/0"
            cell.hp?.text = "0/0"
            cell.adventurerImage?.image = UIImage(named: "test")
            return cell
    }
}
