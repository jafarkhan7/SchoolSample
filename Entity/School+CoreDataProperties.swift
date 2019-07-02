//
//  School+CoreDataProperties.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//
//

import Foundation
import CoreData


extension School {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<School> {
        return NSFetchRequest<School>(entityName: "School")
    }

    @NSManaged public var schoolName: String?
    @NSManaged public var gradeRelationShip: NSSet?

}

// MARK: Generated accessors for gradeRelationShip
extension School {

    @objc(addGradeRelationShipObject:)
    @NSManaged public func addToGradeRelationShip(_ value: Grade)

    @objc(removeGradeRelationShipObject:)
    @NSManaged public func removeFromGradeRelationShip(_ value: Grade)

    @objc(addGradeRelationShip:)
    @NSManaged public func addToGradeRelationShip(_ values: NSSet)

    @objc(removeGradeRelationShip:)
    @NSManaged public func removeFromGradeRelationShip(_ values: NSSet)

}


extension School {
    var grades: [Grade]? {
        var gradesObjects = gradeRelationShip?.allObjects as? [Grade]
         gradesObjects = gradesObjects?.sorted { $0.gradeName ?? "" < $1.gradeName ?? "" }
        return gradesObjects
    }
}
