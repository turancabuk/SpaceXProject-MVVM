//
//  DetailViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import Kingfisher


class DetailViewController: UIViewController {
    
    var didLike: ((RocketPresentation?) -> Void)?
    
    var rocketPresentation : RocketPresentation?

    @IBOutlet weak var rocketDetailImageView: UIImageView!
    @IBOutlet weak var rocketDetailNameLabel: UILabel!
    @IBOutlet weak var rocketDetailDescriptionLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }

    func configure() {
        let url = URL(string: rocketPresentation?.rocket.flickrImages?.first ?? "")
        rocketDetailImageView.kf.setImage(with: url)
        rocketDetailNameLabel.text = rocketPresentation?.rocket.name ?? ""
        rocketDetailDescriptionLabel.text = rocketPresentation?.rocket.welcomeDescription ?? ""
        configureFavorite()
    }

    private func configureFavorite() {
        if rocketPresentation?.isLiked == true {
            favButton.setImage(UIImage(named: "heart2"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "heart1"), for: .normal)
        }
    }
    
    @IBAction func favButtonClicked(_ sender: Any) {
        didLike?(rocketPresentation)
        rocketPresentation?.isLiked = !(rocketPresentation?.isLiked ?? false)
        configureFavorite()
    }
}
