//
//  Section+CoreDataProperties.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//
//

import Foundation
import CoreData


extension Section {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Section> {
        return NSFetchRequest<Section>(entityName: "Section")
    }

    @NSManaged public var sectionName: String?
    @NSManaged public var gradeRelation: Grade?

}
