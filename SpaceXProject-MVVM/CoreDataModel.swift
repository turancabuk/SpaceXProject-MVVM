//
//  CoreDataModel.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 20.10.2022.
//

import Foundation
import CoreData
import UIKit

class Rocket: NSManagedObject{
    
    @NSManaged var rocketName: String
    @NSManaged var rocketDescription: String
}
