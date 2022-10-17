//
//  MainWebService.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 14.10.2022.
//

import Foundation

class MainWebService  {
   
    static let shared = MainWebService()

    func fetchImage(with url: String?, completion: @escaping (Data) -> Void) {
        
        if let urlString = url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    debugPrint(error)
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
            }.resume()
        }
    }

}
