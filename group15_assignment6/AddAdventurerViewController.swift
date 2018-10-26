//
//  AddAdventurerViewController.swift
//  group15_assignment6
//
//  Created by Cathy Li on 10/19/18.
//  Copyright © 2018 CS329E. All rights reserved.
//

import UIKit

var images: [UIImage] = [UIImage(named: "man1")!, UIImage(named: "man2")!, UIImage(named: "man3")!, UIImage(named: "woman1")!, UIImage(named: "woman2")!, UIImage(named: "woman3")!]

class AddAdventurerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var adventurerName: UITextField!
    @IBOutlet weak var adventurerClass: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add an Adventurer"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveAdventurer(_ sender: Any) {
        if adventurerName.text == "" {
            let alert = UIAlertController(title: "Incomplete Submission.", message: "Please fill in a name.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if adventurerClass.text == "" {
            let alert = UIAlertController(title: "Incomplete Submission.", message: "Please fill in a class.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var cancelAdventurer: NSLayoutConstraint!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
     
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.image.image = images[indexPath.row]
        
        if cell.isSelected {
            cell.backgroundColor = UIColor.lightGray
        }
            
        else {
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
        
    }
    
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath as IndexPath)
        cell?.backgroundColor = UIColor.lightGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.clear
    }
    

}
