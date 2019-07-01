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
    var isSelected: Bool? {
        didSet {
            selectGrades(isSelected: isSelected ?? false)
        }
    }
    
    var isExpanded: Bool?
    
   
    
    
}
