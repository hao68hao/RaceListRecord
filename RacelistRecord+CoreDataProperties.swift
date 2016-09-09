//
//  RacelistRecord+CoreDataProperties.swift
//  
//
//  Created by lauda on 16/8/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension RacelistRecord {

    @NSManaged var raceName: String
    @NSManaged var raceDate: String
    @NSManaged var raceDistance: String
    @NSManaged var raceType: String
    @NSManaged var raceImage: NSData
    @NSManaged var raceMoney: String?
    @NSManaged var raceAddress: String
    @NSManaged var raceResult: String
    @NSManaged var raceRating: String?

}
