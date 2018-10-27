//
//  AddAdventurerViewController.swift
//  group15_assignment6
//
//  Created by Cathy Li on 10/19/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit
import CoreData

var images: [UIImage] = [UIImage(named: "man1")!, UIImage(named: "man2")!, UIImage(named: "man3")!, UIImage(named: "woman1")!, UIImage(named: "woman2")!, UIImage(named: "woman3")!]

class AddAdventurerViewController: UIViewController, UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var adventurerName: UITextField!
    @IBOutlet weak var adventurerClass: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add an Adventurer"
        
        self.adventurerName.delegate = self
        adventurerName.text = nil
        adventurerName.placeholder = "Enter name"
        
        self.adventurerClass.delegate = self
        adventurerClass.text = nil
        adventurerClass.placeholder = "Enter profession"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // KEYBOARD HIDING
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    func hideKeyboard() {
        adventurerName.resignFirstResponder()
        adventurerClass.resignFirstResponder()
    }
    
    // PREVENTS SEGUE WHEN NO TEXT IN TEXTFIELDS
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "saveSegue" {
            if (adventurerName.text!.isEmpty) {
                let alert = UIAlertController(title: "Incomplete Submission.", message: "Please fill in a name.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return false
            }
            else if (adventurerClass.text!.isEmpty) {
                let alert = UIAlertController(title: "Incomplete Submission.", message: "Please fill in a class.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return false
            }
            else {
                return true
            }
        }
        
        return true
    }
    
    
    // BUTTONS
    @IBAction func saveAdventurer(_ sender: Any) {
        hideKeyboard()
        let nameInput: String? = self.adventurerName.text
        let classInput: String? = self.adventurerClass.text
        
        if nameInput == "" || classInput == "" {
            print("Error: Missing text field entry.")
        }
        else {
            save(name: nameInput!, profession: classInput!)
        }
    }
    
    @IBOutlet weak var cancelAdventurer: NSLayoutConstraint!
    
    
    // COLLECTION VIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.image.image = images[indexPath.row]
        
        cell.image?.image =  images[(indexPath as NSIndexPath).row]
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        
        return cell
        
    }
        
        
    
    





// SAVE BUTTON FUNCTION (outside view controller class)

func save(name: String, profession: String) {
    
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    let managedContext =
        appDelegate.persistentContainer.viewContext
    
    let entity =
        NSEntityDescription.entity(forEntityName: "Adventurer",
                                   in: managedContext)!
    
    let person = NSManagedObject(entity: entity,
                                 insertInto: managedContext)
    
    
    
    let level: Int = 1
    let attack: Float = Float(arc4random_uniform(1000))/100
    let hp: Int = Int(arc4random_uniform(50) + 50)
    let def: Int = Int(arc4random_uniform(30) + 1)
    let spd: Int = Int(arc4random_uniform(30) + 1)
    
    person.setValue(name, forKey: "name")
    person.setValue(profession, forKey: "profession")
    person.setValue("man1", forKey: "portrait")
    person.setValue(level, forKey: "level")
    person.setValue(hp, forKey: "totalHP")
    person.setValue(attack, forKey: "atkMod")
    person.setValue(hp, forKey: "currentHP")
    person.setValue(def, forKey: "defMod")
    person.setValue(spd, forKey: "spdMod")
    
    // 4
    do {
        try managedContext.save()
        adventurers.append(person)
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

}

