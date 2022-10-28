//
//  FavoriteRocketsViewModel.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 21.10.2022.
//

import UIKit
import CoreData

class FavoriteRocketsViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func loadFavorites(_ compilation: @escaping([Rocket]) -> ()) {
        let request = Rocket.fetchRequest()
        do {
            let result = try context.fetch(request)
            compilation(result)
        } catch {
            print(error.localizedDescription)
        }
    }
}
