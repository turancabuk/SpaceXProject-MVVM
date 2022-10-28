//
//  Rocket+CoreDataProperties.swift
//  SpaceXProject-MVVM
//
//  Created by Turan Çabuk on 21.10.2022.
//
//

import Foundation
import CoreData


extension Rocket {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rocket> {
        return NSFetchRequest<Rocket>(entityName: "Rocket")
    }

    @NSManaged public var rocketDescription: String?
    @NSManaged public var rocketId: String?
    @NSManaged public var rocketImage: String?
    @NSManaged public var rocketName: String?

}

extension Rocket : Identifiable {

}
