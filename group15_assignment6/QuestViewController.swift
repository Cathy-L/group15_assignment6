//
//  QuestViewController.swift
//  group15_assignment6
//
//  Created by Patrick  Switala on 10/25/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit

class QuestViewController: UIViewController {
    
    @IBOutlet weak var questLogField: UITextView!
    @IBOutlet weak var adventurerImage: UIImageView!
    @IBOutlet weak var nameField: UILabel!
    @IBOutlet weak var professionField: UILabel!
    @IBOutlet weak var attackField: UILabel!
    @IBOutlet weak var attackValueField: UILabel!
    @IBOutlet weak var HPValueField: UILabel!
    @IBOutlet weak var levelField: UILabel!
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These following fields need to access info from core data
        let img = "man1"
        adventurerImage?.image = UIImage(named: img)
        let name = "Change this"
        nameField.text = name
        let level = "Level 1"
        levelField.text = level
        let profession = "Change this"
        professionField.text = profession
        let attack = "Nope"
        attackValueField.text = attack
        let hp = "Nope"
        HPValueField.text = hp
        //End of stuff that needs to be connected

        questLogField.text = "Quest Started:"
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(startQuest), userInfo: nil, repeats: true)
    }
    
    
    @objc func startQuest(){
        questLogField.text += "\nTurn"
    }
    
    @IBAction func endQuest(_ sender: UIButton) {
        timer.invalidate()
    }
    
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
