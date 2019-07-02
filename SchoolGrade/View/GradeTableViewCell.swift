//
//  GradeTableViewCell.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import Foundation
import UIKit

enum ClosureMode {
    case expand
    case select
}

class GradeTableViewCell: UITableViewCell {
    var grade:Grade? {
        didSet {
            configureView()
        }
    }
    var closureGrade:(() -> ())?

    
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
        closureGrade?()
    }
    
    @IBAction func buttonActionExpand(_ sender: UIButton) {
        grade?.isExpanded = !(grade?.isExpanded ?? false)
        closureGrade?()
    }
    
    private func makeChangesOnSections() {
        grade?.sections?.forEach { $0.isSelected = grade?.isSelected }
    }
    
}
