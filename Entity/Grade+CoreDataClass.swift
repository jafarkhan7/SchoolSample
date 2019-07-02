//
//  Grade+CoreDataClass.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//
//

import Foundation
import CoreData


public class Grade: NSManagedObject, Selectable, Expandable {
    var isExpanded: Bool?
    var isSelected: Bool?
}

extension Grade {
    //Create grades of school
    class func createGrade(gradeDict:[String:[String]]) -> [Grade] {
        let grades = gradeDict.map { (dict) -> Grade in
            let grade = Grade(context: CoreDataManager.shared.context)
            grade.gradeName = dict.key
            let sections =  Section.createSection(sections: dict.value)
            grade.sectionRelation = NSSet(array: sections)
            
            return grade
        }
        return grades
        
    }
    
}
