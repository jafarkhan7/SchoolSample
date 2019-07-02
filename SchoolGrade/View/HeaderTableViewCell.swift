//
//  HeaderTableViewCell.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit


class HeaderTableViewCell: UITableViewCell {

    var school:School? {
        didSet {
            configureView()
        }
    }
    var closureHeader:(() -> ())?

    @IBOutlet weak var labelHeaderName: UILabel?
    @IBOutlet weak var buttonTick: UIButton?
    @IBOutlet weak var imageViewArrow: UIImageView?

    @IBAction func buttonActionSelected(_ sender: UIButton) {
        school?.isSelected = !(school?.isSelected ?? false)
        makeChangesOnSections()
        closureHeader?()

    }
    
    @IBAction func buttonActionExpanded(_ sender: UIButton) {
        school?.isExpanded = !(school?.isExpanded ?? false)
        closureHeader?()
    }
}

private extension HeaderTableViewCell {
    func configureView() {
        buttonTick?.isSelected = school?.isSelected ?? false
        labelHeaderName?.text = school?.schoolName ?? ""
        imageViewArrow?.rotate(rotate: school?.isExpanded ?? false ? .up : .down)
    }
    
    func makeChangesOnSections() {
        school?.grades?.forEach({ (gradeObject) in
            gradeObject.isSelected = school?.isSelected
            gradeObject.sections?.forEach { $0.isSelected = gradeObject.isSelected }
        })
    }
    
}
