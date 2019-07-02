//
//  SchoolGradeTableViewController.swift
//  SchoolGrade
//
//  Created by Abdus Mac on 7/1/19.
//  Copyright © 2019 Jafar. All rights reserved.
//

import UIKit

class SchoolGradeTableViewController: UITableViewController {
    
    private let coreDataManager = CoreDataManager.shared
    private var school:School? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var grades:[Grade]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var sections:[Section]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
    
    func configureGradeVisbilty () {
        grades =  school?.isExpanded ?? false ? school?.grades : nil
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (grades?.count ?? 0) + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section > 0 {
        let grade = grades?[section - 1]
        return grade?.isExpanded ?? false ? grade?.sections?.count ?? 0 : 0
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.identifier) as? SectionTableViewCell
        tableViewCell?.section = grades?[indexPath.section - 1].sections?[indexPath.row]
        tableViewCell?.closureSection = { [weak self] in
            self?.handleSelection()
        }
        return tableViewCell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:  return configureSchoolHeader()
        default: return configureGradeHeader(section: section - 1)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

private extension SchoolGradeTableViewController {
    
    //School Header
     func configureSchoolHeader() -> UIView? {
        
        let headerTableViewCell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as? HeaderTableViewCell
        headerTableViewCell?.school = school
        headerTableViewCell?.closureHeader = { [weak self] in
            self?.configureGradeVisbilty()
            self?.handleSelection()
        }
        
        return headerTableViewCell
    }
    
    //Grade Header
     func configureGradeHeader(section: Int) -> UIView? {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: GradeTableViewCell.identifier) as? GradeTableViewCell
        
        tableViewCell?.grade = grades?[section]
        tableViewCell?.closureGrade = { [weak self] in
            self?.handleSelection()
        }
        return tableViewCell
    }
    
    //Handling the overall selection
    func handleSelection() {
        school?.grades?.forEach({ (gradeObject) in
            let isSelectedSection = gradeObject.sections?.filter({ (sectionObject) -> Bool in
                sectionObject.isSelected == true
            })
            
            //Selecting the grade by it's section selection
           gradeObject.isSelected = isSelectedSection?.count == gradeObject.sections?.count
        })
        
        let isSelectedGrades = school?.grades?.filter({ (gradeObject) -> Bool in
            gradeObject.isSelected == true
        })
        
        //Selecting the school by it's grade selection
        school?.isSelected = isSelectedGrades?.count == school?.grades?.count
        tableView.reloadData()
    }
    
    func configureDataSource() {
        //Create the school data if school data is unavailable
        guard let schoolObject = coreDataManager.fetch(School.self), schoolObject.count > 0 else {
           school =  School.createSchool()
            return
        }
        school = schoolObject.first
    }
}



