//
//  UIResponderExtension.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/2/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    static var identifier: String {
        return String(describing: self)

    }
}
