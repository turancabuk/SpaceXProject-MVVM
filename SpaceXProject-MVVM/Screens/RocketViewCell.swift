//
//  CellViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import CoreData

class RocketViewCell: UITableViewCell {

    var didLike: (() -> Void)?
   
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketDetailLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(rocketPresentation: RocketPresentation) {
        let url = URL(string: rocketPresentation.rocket.flickrImages?.first ?? "")
        rocketImageView.kf.setImage(with: url)
        rocketNameLabel.text = rocketPresentation.rocket.name
        rocketDetailLabel.text = rocketPresentation.rocket.welcomeDescription
        if rocketPresentation.isLiked {
            favButton.setImage(UIImage(named: "heart2"), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "heart1"), for: .normal)

        }
    }

    @IBAction func favButtonClicked(_ sender: Any) {
        didLike?()
    }
}
