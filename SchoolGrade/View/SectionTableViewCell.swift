//
//  SectionTableViewCell.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit

class SectionTableViewCell: UITableViewCell {
    
    var section: Section? {
        didSet {
            configureView()
        }
    }
    
    var closureSection:(() -> ())?

    @IBOutlet weak var labelHeaderName: UILabel?
    @IBOutlet weak var buttonTick: UIButton?

    private func configureView() {
        buttonTick?.backgroundColor = section?.isSelected ?? false ? .green : .blue
        labelHeaderName?.text = section?.sectionName ?? ""
        
    }
    
    @IBAction func buttonActionSelected(_ sender: UIButton) {
        section?.isSelected = !(section?.isSelected ?? false)
        buttonTick?.backgroundColor = section?.isSelected ?? false ? .green : .blue
        closureSection?()
        
    }
    
}
