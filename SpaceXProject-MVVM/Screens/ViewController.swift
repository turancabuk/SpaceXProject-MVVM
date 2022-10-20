//
//  ViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import Kingfisher
import CoreData

struct RocketPresentation {
    var isLiked: Bool
    let rocket: RocketResponse
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
  
    var viewModel: MainViewModel?
    var selectedRocket: RocketPresentation!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellViewController
        let rocketPresentation = response[indexPath.row]
        cell.configure(rocketPresentation: rocketPresentation)
        cell.didLike = { [weak self] in
            guard let self = self else {
                return
            }
            self.response[indexPath.row].isLiked = !rocketPresentation.isLiked
            self.tableView.reloadData()
        }
        
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRocket = response[indexPath.row]
        performSegue(withIdentifier: "toRocketDetailVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRocketDetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.chosenRocket = 
        }
    }

    @IBAction func favButtonClicked(_ sender: Any) {
        
       

    }
}

