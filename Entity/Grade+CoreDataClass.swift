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
    
    var isSelected: Bool? {
        didSet {
            selectSection(isSelected: isSelected ?? false)
        }
    }
    

}
