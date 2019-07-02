//
//  UIViewExtension.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/2/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit
extension UIView {
    enum Direction {
        case up
        case down
        
    }
    func rotate(rotate: Direction) {
        UIView.animate(withDuration: 2, animations: { [weak self] in
            let value = rotate == .up ? CGFloat(Double.pi) : 0.0
            self?.transform = CGAffineTransform(rotationAngle: value)
        })
    }
}
