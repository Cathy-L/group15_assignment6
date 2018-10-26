//
//  ViewController.swift
//  group15_assignment6
//
//  Created by Cathy Li on 10/18/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var adventurers: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adventurers"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Adventurer")
        
        // START TEST ADVENTURER CODE

        let entity = NSEntityDescription.entity(forEntityName: "Adventurer", in: managedContext)
        let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)
        newUser.setValue("Qwee", forKey: "name")
        newUser.setValue("man1", forKey: "portrait")
        newUser.setValue("Priest", forKey: "profession")
        newUser.setValue(2, forKey: "level")
        newUser.setValue(10, forKey: "totalHP")
        newUser.setValue(5, forKey: "currentHP")
        newUser.setValue(5, forKey: "atkMod")
        newUser.setValue(6, forKey: "defMod")
        newUser.setValue(7, forKey: "spdMod")
 
        // END TEST ADVENTURER CODE
        
        do {
            adventurers = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }


    @IBAction func addMember(_ sender: UIBarButtonItem) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return adventurers.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let adventurer = adventurers[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "AdventurerTableViewCell",
                                              for: indexPath) as! AdventurerTableViewCell
            cell.name?.text =
                adventurer.value(forKeyPath: "name") as? String
            cell.profession?.text =
                adventurer.value(forKeyPath: "profession") as? String
            let img = adventurer.value(forKeyPath: "portrait") as? String
            cell.adventurerImage?.image = UIImage(named: img!)
            let lvl = adventurer.value(forKeyPath: "level") as? Int
            cell.level?.text = "\(lvl!)"
            let tothp = adventurer.value(forKeyPath: "totalHP") as? Int
            let currhp = adventurer.value(forKey: "currentHP") as? Int
            cell.hp?.text = "\(currhp!)/\(tothp!)"
            let atk = adventurer.value(forKeyPath: "atkMod") as? Int
            cell.attack?.text = "\(atk!)"
            let def = adventurer.value(forKeyPath: "defMod") as? Int
            cell.defense?.text = "\(def!)"
            let spd = adventurer.value(forKeyPath: "spdMod") as? Int
            cell.speed?.text = "\(spd!)"
            return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            
            managedContext.delete(adventurers[indexPath.row])
            do {
                try managedContext.save()
                tableView.reloadData()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            //self.adventurers.remove(at: indexPath.row)
            //tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Adventurer")
        
        do {
            adventurers = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        
        tableView.reloadData()
        
    }
    
}
