//
//  MainViewModel.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import Foundation

class MainViewModel {
    
    func fetchRockets(completion: @escaping ([RocketResponse]?) -> ()) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else {
             return

        }
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    if let error = error {
                        debugPrint(error)
                            completion(nil)
                    }
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode([RocketResponse].self, from: data)
                            completion(response)
                            
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
    }
}
