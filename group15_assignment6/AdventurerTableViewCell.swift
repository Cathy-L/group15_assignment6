//
//  AdventurerTableViewCell.swift
//  group15_assignment6
//
//  Created by Cathy Li on 10/18/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit

class AdventurerTableViewCell: UITableViewCell {

    @IBOutlet weak var adventurerImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var profession: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var speed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
