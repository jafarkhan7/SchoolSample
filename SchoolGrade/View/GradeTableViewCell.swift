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
    
    @IBOutlet weak var imageViewArrow: UIImageView?
    @IBOutlet weak var labelHeaderName: UILabel?
    @IBOutlet weak var buttonTick: UIButton?
    
    @IBAction func buttonActionSelected(_ sender: UIButton) {
        grade?.isSelected = !(grade?.isSelected ?? false)
        makeChangesOnSections()
        closureGrade?()
    }
    
    @IBAction func buttonActionExpand(_ sender: UIButton) {
        grade?.isExpanded = !(grade?.isExpanded ?? false)
        closureGrade?()
    }
}

private extension GradeTableViewCell {
    
    func makeChangesOnSections() {
        grade?.sections?.forEach { $0.isSelected = grade?.isSelected }
    }
    
    func configureView() {
        labelHeaderName?.text = grade?.gradeName ?? ""
        buttonTick?.isSelected = (grade?.isSelected ?? false)
        imageViewArrow?.rotate(rotate: grade?.isExpanded ?? false ? .up : .down)
        
    }
}
