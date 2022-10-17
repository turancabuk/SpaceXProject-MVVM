//
//  ViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import Kingfisher

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

   
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel?
    
    var selectedRocket: RocketResponse!
    
    var response: [RocketResponse] = [] {
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
        
        viewModel?.fetchRockets(completion: { [weak self] rocketList in
            if rocketList != nil {
                self?.response = rocketList!
                
            } else {
                print("alert")
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
        let rocket = response[indexPath.row]
        let url = URL(string: rocket.flickrImages?.last ?? "")
        cell.rocketImageView.kf.setImage(with: url)
        cell.rocketNameLabel.text = rocket.name
        cell.rocketDetailLabel.text = rocket.welcomeDescription
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedRocket = response[indexPath.row]
        performSegue(withIdentifier: "toRocketDetailVC", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toRocketDetailVC" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.chosenRocket = selectedRocket
        }
    }
    @IBAction func favButtonClicked(_ sender: Any) {
    }
}

