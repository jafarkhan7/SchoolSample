//
//  Protocols.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/2/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation

protocol Selectable {
    var isSelected: Bool? { get set }
}

protocol Expandable {
    var isExpanded: Bool? { get set }
}
