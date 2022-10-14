//
//  CellViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit

class CellViewController: UITableViewCell {

    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketDetailLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favButtonClicked(_ sender: Any) {
    }
}
