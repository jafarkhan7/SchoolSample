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

    
    private func configureView() {
        buttonTick?.backgroundColor = school?.isSelected ?? false ? .green : .blue
        labelHeaderName?.text = school?.schoolName ?? ""
    }
    
    @IBOutlet weak var labelHeaderName: UILabel?
    @IBOutlet weak var buttonTick: UIButton?
    
    @IBAction func buttonActionSelected(_ sender: UIButton) {
        school?.isSelected = !(school?.isSelected ?? false)
        buttonTick?.backgroundColor = school?.isSelected ?? false ? .green : .blue
        makeChangesOnSections()
        closureHeader?()
    }
    
    @IBAction func buttonActionExpanded(_ sender: UIButton) {
        school?.isExpanded = !(school?.isExpanded ?? false)
        closureHeader?()
    }
    
    private func makeChangesOnSections() {
        school?.grades?.forEach({ (gradeObject) in
            gradeObject.isSelected = school?.isSelected
            gradeObject.sections?.forEach { $0.isSelected = gradeObject.isSelected }
        })
    }
    
}
