//
//  Photo+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Dmitrii Tikhomirov on 4/22/23.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var url: String?
    @NSManaged public var title: String?
}

extension Photo : Identifiable {

}
