//
//  ViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import Kingfisher
import CoreData

class RocketPresentation {
    var isLiked: Bool
    let rocket: RocketResponse
    
    init(isLiked: Bool, rocket: RocketResponse) {
        self.isLiked = isLiked
        self.rocket = rocket
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
  
    var viewModel: MainViewModel?
    var selectedRocket: RocketPresentation!
    private var selectedPosition = 0
    
    var response: [RocketPresentation] = [] {
    didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = MainViewModel()
        
        fetchRecentRockets()
        
       
        
    }
    private func fetchRecentRockets() {
        
        viewModel?.fetchRockets(completion: { [weak self] response in
            switch response {
            case.success(let rocketList):
                self?.response = rocketList
            case.failure(let error):
                print(error)
            }
        
            
        })
       
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RocketViewCell
        let rocketPresentation = response[indexPath.row]
        cell.configure(rocketPresentation: rocketPresentation)
        cell.didLike = { [weak self] in
            guard let self = self else {
                return
            }
            let rocket = self.response[indexPath.row]
            
            if rocket.isLiked {
                self.viewModel?.deleteRocketFavorite(rocket.rocket)
            } else {
                self.viewModel?.saveRocketFavorite(rocket.rocket)
            }
            
            rocket.isLiked = !rocketPresentation.isLiked
            self.tableView.reloadData()
        }
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPosition = indexPath.row
        selectedRocket = response[selectedPosition]
        performSegue(withIdentifier: "toRocketDetailVC", sender: selectedRocket)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRocketDetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.rocketPresentation = sender as? RocketPresentation
            destinationVC.didLike = { rocket in
                if rocket?.isLiked == true, let rocket = rocket {
                    self.viewModel?.deleteRocketFavorite(rocket.rocket)
                } else {
                    if let rocket = rocket {
                        self.viewModel?.saveRocketFavorite(rocket.rocket)
                    }
                }
                self.response[self.selectedPosition].isLiked = rocket?.isLiked ?? false
                self.tableView.reloadData()
            }
            
        }
    }
}

