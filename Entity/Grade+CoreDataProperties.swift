//
//  Grade+CoreDataProperties.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//
//

import Foundation
import CoreData


extension Grade {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Grade> {
        return NSFetchRequest<Grade>(entityName: "Grade")
    }

    @NSManaged public var gradeName: String?
    @NSManaged public var schoolRelation: School?
    @NSManaged public var sectionRelation: NSSet?

}

// MARK: Generated accessors for sectionRelation
extension Grade {

    @objc(addSectionRelationObject:)
    @NSManaged public func addToSectionRelation(_ value: Section)

    @objc(removeSectionRelationObject:)
    @NSManaged public func removeFromSectionRelation(_ value: Section)

    @objc(addSectionRelation:)
    @NSManaged public func addToSectionRelation(_ values: NSSet)

    @objc(removeSectionRelation:)
    @NSManaged public func removeFromSectionRelation(_ values: NSSet)

}

extension Grade {
    var sections:[Section]? {
        var sectionObjects = sectionRelation?.allObjects as? [Section]
        sectionObjects = sectionObjects?.sorted { $0.sectionName ?? "" < $1.sectionName ?? "" }
     return sectionObjects
    }
    
    func selectSection(isSelected: Bool) {
        sections?.forEach { $0.isSelected = isSelected }
    }
}


protocol Selectable {
    var isSelected: Bool? { get set }    
}

protocol Expandable {
    var isExpanded: Bool? { get set }
}
