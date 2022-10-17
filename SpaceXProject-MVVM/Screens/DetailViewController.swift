//
//  DetailViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var chosenRocket : RocketResponse?

    @IBOutlet weak var rocketDetailImageView: UIImageView!
    @IBOutlet weak var rocketDetailNameLabel: UILabel!
    @IBOutlet weak var rocketDetailDescriptionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        
        rocketDetailNameLabel.text = chosenRocket?.name
        rocketDetailDescriptionLabel.text = chosenRocket?.welcomeDescription
        let url = URL(string: "\(chosenRocket?.flickrImages?.first ?? "")")
        rocketDetailImageView.kf.setImage(with: url)
        
        
        


    }

    
    @IBAction func likeButtonDidClicked(_ sender: Any) {
    }
    

}
