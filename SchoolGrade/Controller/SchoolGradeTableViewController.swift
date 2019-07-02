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
    
    func configureTableUI () {
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
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCell") as? SectionTableViewCell
        tableViewCell?.section = grades?[indexPath.section - 1].sections?[indexPath.row]
        tableViewCell?.closureSection = { [weak self] in
            self?.handleSelection()
        }
        return tableViewCell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            let headerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as? HeaderTableViewCell
            headerTableViewCell?.school = school
            headerTableViewCell?.closureHeader = { [weak self] in
                self?.configureTableUI()
                self?.handleSelection()
            }
            
            return headerTableViewCell
        default:
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "GradeTableViewCell") as? GradeTableViewCell
            
            tableViewCell?.grade = grades?[section - 1]
            tableViewCell?.closureGrade = { [weak self] in
                self?.handleSelection()
            }
            return tableViewCell
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did Select")
    }
    
}

private extension SchoolGradeTableViewController {
    
    func handleSelection() {
        school?.grades?.forEach({ (gradeObject) in
            let isSelectedSection = gradeObject.sections?.filter({ (sectionObject) -> Bool in
                sectionObject.isSelected == true
            })
           gradeObject.isSelected = isSelectedSection?.count == gradeObject.sections?.count
        })
        
        let isSelectedGrades = school?.grades?.filter({ (gradeObject) -> Bool in
            gradeObject.isSelected == true
        })
        school?.isSelected = isSelectedGrades?.count == school?.grades?.count
        
        tableView.reloadData()
        
    }
    
    func configureDataSource() {
        guard let schoolObject = coreDataManager.fetch(School.self), schoolObject.count > 0 else {
           school =  createSchool()
            return
        }
        
        school = schoolObject.first
    }
    
    func createSchool() -> School? {
        let schoolDict = ["Schools": [["name": "ALL", "grades": ["Grade1": ["A", "B"], "Grade2": ["A", "B"]]]]]
        guard let schoolObjects =  schoolDict["Schools"] else {
            return nil;
        }
        let schoolObject = schoolObjects.map { (schoolObject) -> School in
            let school = School(context: coreDataManager.context)
            school.schoolName = (schoolObject["name"] as? String) ?? ""
            
            if let gradeDict = schoolObject["grades"] as? [String:[String]] {
                let grades =  initializeGrade(gradeDict: gradeDict)
                school.gradeRelationShip = NSSet(array: grades)
            }
            
            return school
        }
        print(schoolObject)
        coreDataManager.saveContext()
        return schoolObject.first
    }
    
    
    func initializeGrade(gradeDict:[String:[String]]) -> [Grade] {
        let grades = gradeDict.map { (dict) -> Grade in
            let grade = Grade(context: coreDataManager.context)
            grade.gradeName = dict.key
            let sections =  initializeSection(sections: dict.value)
            grade.sectionRelation = NSSet(array: sections)
            
            return grade
        }
        return grades
        
    }
    
    func initializeSection(sections:[String]) -> [Section] {
        let sections = sections.map({ (sectionName) -> Section in
            let gradeSection = Section(context: coreDataManager.context)
            gradeSection.sectionName = sectionName
            return gradeSection
        })
        
        return sections
    }
    
    
}



