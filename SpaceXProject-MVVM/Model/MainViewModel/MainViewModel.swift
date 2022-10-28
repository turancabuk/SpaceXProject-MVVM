//
//  MainViewModel.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import UIKit
import CoreData

class MainViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchRockets(completion: @escaping (Result<[RocketPresentation], Error>) -> ()) {
        
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else {
             return

        }
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    
                    if let error = error {
                        debugPrint(error)
                        completion(.failure(error))
                    }
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode([RocketResponse].self, from: data)
                            let rocketListFromDatabase = self.loadFromDatabase()
                            let rocketFromNetwork = response.map{RocketPresentation(isLiked: false, rocket: $0)}
                            self.checkForAlreadyFavorite(rocketListFromDatabase, rocketFromNetwork)
                            completion(.success(rocketFromNetwork))
                        } catch {
                            print(error)
                        }
                    }
                }.resume()
    }
    
    private func loadFromDatabase() -> [Rocket] {
        let fetchRequest = Rocket.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            let nsError = error as NSError
            print(nsError.localizedDescription)
            return []
        }
    }
    
    private func checkForAlreadyFavorite(_ rocketListFromDatabase: [Rocket], _ rocketFromNetwork: [RocketPresentation]) {
        for network in rocketFromNetwork {
            for local in rocketListFromDatabase {
                if network.rocket.id == local.rocketId {
                    network.isLiked = true
                    break
                }
            }
        }
    }
    
    func saveRocketFavorite(_ rocket: RocketResponse) {
        let rocketEntity = Rocket(context: context)
        rocketEntity.rocketId = rocket.id
        rocketEntity.rocketName = rocket.name
        rocketEntity.rocketDescription = rocket.welcomeDescription
        rocketEntity.rocketImage = rocket.flickrImages?.first ?? ""

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteRocketFavorite(_ rocket: RocketResponse) {
        let fetchRequest = Rocket.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "rocketId == %@", rocket.id ?? "")
        
        do {
            let result = try context.fetch(fetchRequest)
            for rocket in result {
                context.delete(rocket)
            }
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
