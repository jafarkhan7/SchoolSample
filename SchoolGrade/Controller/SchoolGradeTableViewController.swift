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
    
    @IBOutlet weak var labelHeader: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDataSource()
    }
    
    @IBAction func actionButtonExpand(_ sender: UIButton) {
        
        school?.isExpanded = !(school?.isExpanded ?? false)
        grades = (school?.isExpanded ?? false) ? school?.grades : nil

    }
    
    
    @IBAction func showAll(_ sender: UIButton) {
        school?.isSelected = !(school?.isSelected ?? false)
        sender.backgroundColor = (school?.isSelected ?? false) ? .green : .blue
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return grades?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let grade = grades?[section]
        return grade?.isExpanded ?? false ? grade?.sections?.count ?? 0 : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "SectionTableViewCell") as? SectionTableViewCell
        tableViewCell?.section = grades?[indexPath.section].sections?[indexPath.row]
        return tableViewCell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "GradeTableViewCell") as? GradeTableViewCell

        tableViewCell?.grade = grades?[section]

        tableViewCell?.closureSection = { [weak self] isExpanded in
            self?.grades?[section].isExpanded = isExpanded
            self?.tableView.reloadData()
        }
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did Select")
    }
    
}

fileprivate extension SchoolGradeTableViewController {
    
    func configureDataSource() {
        guard let schoolObject = coreDataManager.fetch(School.self), schoolObject.count > 0 else {
           school =  createSchool()
            
            return
        }
        
        school = schoolObject.first
        labelHeader?.text = school?.schoolName ?? ""
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



