//
//  Banner+CoreDataProperties.swift
//  test_problem_onlym
//
//  Created by Khurshed Umarov on 18.10.2021.
//
//

import Foundation
import CoreData


extension Banner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Banner> {
        return NSFetchRequest<Banner>(entityName: "Banner")
    }

    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var active: Bool

}

extension Banner : Identifiable {

}
