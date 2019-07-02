//
//  School+CoreDataClass.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//
//

import Foundation
import CoreData


public class School: NSManagedObject, Selectable, Expandable {
    var isSelected: Bool? 
    var isExpanded: Bool?
}

extension School {
    class func createSchool() -> School? {
        let schoolDict = ["Schools": [["name": "ALL", "grades": ["Grade1": ["A", "B"], "Grade2": ["A", "B"]]]]]
        guard let schoolObjects =  schoolDict["Schools"] else {
            return nil;
        }
        let schoolObject = schoolObjects.map { (schoolObject) -> School in
            let school = School(context: CoreDataManager.shared.context)
            school.schoolName = (schoolObject["name"] as? String) ?? ""
            
            if let gradeDict = schoolObject["grades"] as? [String:[String]] {
                let grades =  Grade.createGrade(gradeDict: gradeDict)
                school.gradeRelationShip = NSSet(array: grades)
            }
            
            return school
        }
        print(schoolObject)
        CoreDataManager.shared.saveContext()
        return schoolObject.first
    }
}
