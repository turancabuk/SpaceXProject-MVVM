//
//  DetailViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var didLike: (() -> Void)?

    
    var chosenRocket : RocketResponse?

    @IBOutlet weak var rocketDetailImageView: UIImageView!
    @IBOutlet weak var rocketDetailNameLabel: UILabel!
    @IBOutlet weak var rocketDetailDescriptionLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        
        
        
        rocketDetailNameLabel.text = chosenRocket?.name
        rocketDetailDescriptionLabel.text = chosenRocket?.welcomeDescription
        let url = URL(string: "\(chosenRocket?.flickrImages?.first ?? "")")
        rocketDetailImageView.kf.setImage(with: url)
        
        
        


    }
    func configure(rocketPresentation: RocketPresentation) {
        let url = URL(string: rocketPresentation.rocket.flickrImages?.first ?? "")
        rocketDetailImageView.kf.setImage(with: url)
        rocketDetailNameLabel.text = rocketPresentation.rocket.name
        rocketDetailDescriptionLabel.text = rocketPresentation.rocket.welcomeDescription
        if rocketPresentation.isLiked {
            favButton.setImage(UIImage(named: "heart2"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "heart1"), for: .normal)

        }
    }

    @IBAction func likeButtonDidClicked(_ sender: Any) {
        
        didLike?()
    }
}
