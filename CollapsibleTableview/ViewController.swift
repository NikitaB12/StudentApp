//
//  ViewController.swift
//  CollapsibleTableview
//
//  Created by Nikita Vilas Barhate on 01/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tblView : UITableView!

    var viewModel = ViewModel()
    var students = [Student]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
    }

    public func setUpData() {
        tblView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        students =  viewModel.getStudents()
        
        
    }
    
    public func getStudentsFromGrade(grade : Grade) -> [Student]{
        let gradeStudents = students.filter { student in
            student.grade == grade
        }
        return gradeStudents.sorted { s1, s2 in
            s1.roll_no <= s2.roll_no
        }
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return getStudentsFromGrade(grade: .A).count
        case 1:
            return getStudentsFromGrade(grade: .B).count
        case 2:
            return getStudentsFromGrade(grade: .C).count
        case 3:
            return getStudentsFromGrade(grade: .D).count
        
        default:
            print("In Default Switch Condition")
            return 0
        }
//        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self), for: indexPath) as! CustomTableViewCell
        switch indexPath.section {
        case 0:
            cell.student = getStudentsFromGrade(grade: .A)[indexPath.row]
        case 1:
            cell.student = getStudentsFromGrade(grade: .B)[indexPath.row]
        case 2:
            cell.student = getStudentsFromGrade(grade: .C)[indexPath.row]
        case 3:
            cell.student = getStudentsFromGrade(grade: .D)[indexPath.row]
        default:
            print("Default Switch Condition")
        }
        
//        cell.student = students[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return Grade.allCases.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Grade.allCases[section].rawValue
    }
    
}
