//
//  CoreDataModel.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 19.10.2022.
//

import Foundation
import CoreData

@objc(Rocket)
class CoreDataModel: NSManagedObject {
    
    @NSManaged var rocketName: String!
    @NSManaged var rocketDescription: String!
    @NSManaged var rocketId: NSNumber!
}
