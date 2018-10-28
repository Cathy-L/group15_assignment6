//
//  QuestViewController.swift
//  group15_assignment6
//
//  Created by Nabeel Masood on 10/25/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit
import CoreData

class QuestViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var questView: UITextView!
    
    var selectedAdventurer:NSManagedObject?
    var timer = Timer()
    var enemyTimer = Timer()
    
    var name: String = ""
    var attack:UInt16 = 0
    var currentHP:UInt16?
    var totalHP:UInt16?
    var level:UInt16?
    var exp:UInt16 = 0
    
    var enemyHP: UInt16 = 20
    var enemyAtk:UInt16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = selectedAdventurer!.value(forKeyPath: "portrait") as! String
        pictureView?.image = UIImage(named: img)
        name = selectedAdventurer!.value(forKeyPath: "name") as! String
        nameLabel.text = name
        level = selectedAdventurer!.value(forKeyPath: "level") as! UInt16
        lvlLabel.text = "Level \(level!)"
        let profession = selectedAdventurer!.value(forKeyPath: "profession") as! String
        professionLabel.text = profession
        attack = selectedAdventurer!.value(forKeyPath: "atkMod") as! UInt16
        attackLabel.text = String(attack)
        totalHP = selectedAdventurer!.value(forKeyPath: "totalHP") as! UInt16
        selectedAdventurer!.setValue(totalHP, forKey: "currentHP")
        currentHP = selectedAdventurer!.value(forKeyPath: "currentHP") as! UInt16
        hpLabel.text = "\(currentHP!) / \(totalHP!)"
        
        questView.text = "*** Quest Started ***"
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(adventurerAttack), userInfo: nil, repeats: true)
        enemyTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(enemyAttack), userInfo: nil, repeats: true)
    }
    
    
    @objc func adventurerAttack(){
        /*
         "attack" is supposed to be subtracted from "currentHP" below, but when it done that way, the program crashes a few turns after the player reaches level 2 for an unknown reason.  The program also crashes when a values that isn't 5 is subtracted from currentHP
         */
        enemyHP -= 5
        //enemyHP -= attack
        if enemyHP <= 0 {
            questView.text = "\(name) attacks!  Enemy is Defeated!\n" + questView.text!
            
            exp += 1
            if exp > 2 {
                level! += 1
                selectedAdventurer!.setValue(level, forKey: "level")
                lvlLabel.text = "Level \(level!)"
                totalHP! += 1
                selectedAdventurer!.setValue(totalHP, forKey: "totalHP")
                currentHP = totalHP
                hpLabel.text = "\(currentHP!) / \(totalHP!)"
                attack = UInt16(attack + 1)
                selectedAdventurer!.setValue(attack, forKey: "atkMod")
                attackLabel.text = String(attack)
                questView.text = "\nLevel up!  \(name) is now Level \(level!)\n\n" + questView.text!
                exp = 0
            }
            
            questView.text = "Oh no, new enemy approaches!\n" + questView.text!
            enemyHP = 20
        } else {
            questView.text = "\(name) attacks the enemy!  Enemy HP is now \(enemyHP)/20\n" + questView.text!
        }
    }
    
    @objc func enemyAttack(){
        let wait = arc4random_uniform(6)
        if wait < 2 {
            questView.text = "Enemy is waiting\n" + questView.text
        } else {
            enemyAtk = 1 + UInt16(arc4random_uniform(2))
            currentHP! -= enemyAtk
            selectedAdventurer!.setValue(currentHP, forKey: "currentHP")
            if currentHP! <= 0 {
                currentHP! = 0
                questView.text = "\(name) is defeated\n" + questView.text!
                timer.invalidate()
                enemyTimer.invalidate()
            } else {
                questView.text = "Enemy attacks for \(enemyAtk) damage!  current HP is now \(currentHP!)/\(totalHP!)\n" + questView.text!
            }
            hpLabel.text = "\(currentHP!) / \(totalHP!)"
            }
    }
    

    @IBAction func endQuestButton(_ sender: UIButton) {
        timer.invalidate()
        enemyTimer.invalidate()
        questView.text = "*** Quest Ended ***\n" + questView.text!
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
