//
//  CellViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import CoreData

class CellViewController: UITableViewCell {

    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketDetailLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favButtonClicked(_ sender: Any) {
        
        if favButton.tag == 0 {
            favButton.setImage(UIImage(named: "heart1"), for: .normal)
            favButton.tag = 1
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Rocket", in: context)
            let newRocket = CoreDataModel(entity: entity!, insertInto: context)
        
        }else{
            favButton.setImage(UIImage(named: "heart2"), for: .normal)
            favButton.tag = 0
        }
    }
    
    
}
