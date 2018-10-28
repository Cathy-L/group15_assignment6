//
//  ViewController.swift
//  group15_assignment6
//
//  Created by Cathy Li on 10/18/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit
import CoreData

var adventurers: [NSManagedObject] = []
var selectedAdventurer:NSManagedObject?

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var selectedAdventurer:NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Adventurers"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        
    }
    
 
    /*
    func saveAdventurer(name: String, profession: String, picture: UIImage) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedContext
        let entity =  NSEntityDescription.entityForName("Adventurer", inManagedObjectContext:managedContext)
        let adventurer = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        let datapicture: NSData = UIImagePNGRepresentation(picture)! as NSData
        
        let level: Int = 1
        let attack: Float = Float(arc4random_uniform(1000))/100
        let health: Int = Int(arc4random_uniform(50) + 50)
        
        adventurer.setValue(name, forKey: "name")
        adventurer.setValue(profession, forKey: "profession")
        adventurer.setValue(level, forKey: "level")
        adventurer.setValue(attack, forKey: "attack")
        adventurer.setValue(health, forKey: "health")
        adventurer.setValue(datapicture, forKey: "picture")
        
        do {
            try managedContext.save()
            adventurers.append(adventurer)
        }
            
        catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    */
    
    
    
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
        
/*
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
*/
        
        do {
            adventurers = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    

    
    @IBAction func addMember(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "addMember", sender: self)
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
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        
        if segue.destination is QuestViewController {
            let contentViewController = segue.destination as! QuestViewController
        
            if let selectedCell = sender as? AdventurerTableViewCell{
                let indexPath = tableView.indexPath(for: selectedCell)
                let adventurer = adventurers[indexPath!.row]
                contentViewController.selectedAdventurer = adventurer
            }
        }
        
        
    }

}

