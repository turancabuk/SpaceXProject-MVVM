//
//  FavoriteRocketsViewController.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 21.10.2022.
//

import UIKit

class FavoriteRocketsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    
    var viewModel: FavoriteRocketsViewModel? = FavoriteRocketsViewModel()
    private var items: [Rocket] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViews()
        loadFavorites()
    }
    
    private func loadFavorites() {
        viewModel?.loadFavorites({ array in
            self.items.removeAll(keepingCapacity: false)
            self.items.append(contentsOf: array)
            self.tableView.reloadData()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }

    private func configureViews() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CELL")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.rocketName ?? "Empty"
        return cell
    }

}
