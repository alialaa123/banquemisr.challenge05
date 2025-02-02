//
//  CinemaEntity+CoreDataProperties.swift
//  banquemisr.challenge05
//
//  Created by ali alaa on 02/02/2025.
//
//

import Foundation
import CoreData


extension CinemaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CinemaEntity> {
        return NSFetchRequest<CinemaEntity>(entityName: "CinemaEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var movieImage: String?
    @NSManaged public var movieTitle: String?

}
