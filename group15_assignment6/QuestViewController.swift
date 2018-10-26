//
//  QuestViewController.swift
//  group15_assignment6
//
//  Created by Nabeel Masood on 10/25/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit

class QuestViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var questView: UITextView!
    
    var name: String?
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //These following fields need to access info from core data
        let img = "man1"
        pictureView?.image = UIImage(named: img)
        //let name = "Change this"
        nameLabel.text = name
        let level = "Level 1"
        lvlLabel.text = level
        let profession = "Change this"
        professionLabel.text = profession
        let attack = "Nope"
        attackLabel.text = attack
        let hp = "Nope"
        hpLabel.text = hp
        //End of stuff that needs to be connected
        
        questView.text = "Quest Started:"
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(startQuest), userInfo: nil, repeats: true)
    }
    
    
    @objc func startQuest(){
        questView.text = questView.text! + "\nTurn"
    }

    @IBAction func endQuestButton(_ sender: UIButton) {
        timer.invalidate()
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
