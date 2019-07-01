//
//  GradeTableViewCell.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit

class GradeTableViewCell: UITableViewCell {
    
    var grade:Grade? {
        didSet {
            configureView()
        }
    }
    var closureSection:((Bool) -> ())?
    
    
    private func configureView() {
        buttonTick?.backgroundColor = grade?.isSelected ?? false ? .green : .blue
        labelHeaderName?.text = grade?.gradeName ?? ""
    }
    
    @IBOutlet weak var labelHeaderName: UILabel?
    @IBOutlet weak var buttonTick: UIButton?
    
    @IBAction func buttonActionSelected(_ sender: UIButton) {
        grade?.isSelected = !(grade?.isSelected ?? false)
        buttonTick?.backgroundColor = grade?.isSelected ?? false ? .green : .blue
        makeChangesOnSections()
    }
    
    @IBAction func buttonActionExpand(_ sender: UIButton) {
        grade?.isExpanded = !(grade?.isExpanded ?? false)
        closureSection?(grade?.isExpanded ?? false)
    }
    
    private func makeChangesOnSections() {
        grade?.sections?.forEach { $0.isSelected = grade?.isSelected }
    }
    
}
