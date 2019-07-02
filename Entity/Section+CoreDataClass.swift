//
//  Section+CoreDataClass.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//
//

import Foundation
import CoreData


public class Section: NSManagedObject, Selectable {
    var isSelected: Bool?
}

extension Section {
    //Create sections of grades
    class func createSection(sections:[String]) -> [Section] {
        let sections = sections.map({ (sectionName) -> Section in
            let gradeSection = Section(context: CoreDataManager.shared.context)
            gradeSection.sectionName = sectionName
            return gradeSection
        })
        
        return sections
    }
}
