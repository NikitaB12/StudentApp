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
    var expandedSectionHeaderNumber: Int = -1
    var expandedSectionHeader: UITableViewHeaderFooterView!
    let kHeaderSectionTag: Int = 6900;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpData()
        self.tblView.tableFooterView = UIView()
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
        if self.expandedSectionHeaderNumber == section {
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
        } else {
            return 0;
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 44.0;
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
            return 0;
        }
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            //recast your view as a UITableViewHeaderFooterView
            let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            header.contentView.backgroundColor = UIColor(red: 0.86, green: 0.47, blue: 0.24, alpha: 1.00)
            header.textLabel?.textColor = UIColor.white
            
            if let viewWithTag = self.view.viewWithTag(kHeaderSectionTag + section) {
                viewWithTag.removeFromSuperview()
            }
            let headerFrame = self.view.frame.size
            let theImageView = UIImageView(frame: CGRect(x: headerFrame.width - 25, y: 13, width: 12, height: 12));
            theImageView.image = UIImage(named: "download")
            theImageView.tintColor = UIColor.white
            theImageView.tag = kHeaderSectionTag + section
            header.addSubview(theImageView)
            
            // make headers touchable
            header.tag = section
            let headerTapGesture = UITapGestureRecognizer()
            headerTapGesture.addTarget(self, action: #selector(ViewController.sectionHeaderWasTouched(_:)))
            header.addGestureRecognizer(headerTapGesture)
        }
    
    
    @objc func sectionHeaderWasTouched(_ sender: UITapGestureRecognizer) {
            let headerView = sender.view as! UITableViewHeaderFooterView
            let section    = headerView.tag
            let eImageView = headerView.viewWithTag(kHeaderSectionTag + section) as? UIImageView
            
            if (self.expandedSectionHeaderNumber == -1) {
                self.expandedSectionHeaderNumber = section
                tableViewExpandSection(section, imageView: eImageView!)
            } else {
                if (self.expandedSectionHeaderNumber == section) {
                    tableViewCollapeSection(section, imageView: eImageView!)
                } else {
                    let cImageView = self.view.viewWithTag(kHeaderSectionTag + self.expandedSectionHeaderNumber) as? UIImageView
                    tableViewCollapeSection(self.expandedSectionHeaderNumber, imageView: cImageView!)
                    tableViewExpandSection(section, imageView: eImageView!)
                }
            }
        }
        
        func tableViewCollapeSection(_ section: Int, imageView: UIImageView) {
            var sectionData : NSArray!
            
            
            switch section {
            case 0:
                sectionData = getStudentsFromGrade(grade: .A) as NSArray
            case 1:
                sectionData = getStudentsFromGrade(grade: .B) as NSArray
            case 2:
                sectionData = getStudentsFromGrade(grade: .C) as NSArray
            case 3:
                sectionData = getStudentsFromGrade(grade: .D) as NSArray
            default:
                print("Default Switch Condition")
            }
            
            self.expandedSectionHeaderNumber = -1;
            if (sectionData.count == 0) {
                return;
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    imageView.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
                })
                var indexesPath = [IndexPath]()
                for i in 0 ..< sectionData.count {
                    let index = IndexPath(row: i, section: section)
                    indexesPath.append(index)
                }
                self.tblView!.beginUpdates()
                self.tblView!.deleteRows(at: indexesPath, with: UITableView.RowAnimation.fade)
                self.tblView!.endUpdates()
            }
        }
        
        func tableViewExpandSection(_ section: Int, imageView: UIImageView) {
            var sectionData : NSArray!
            
            
            switch section {
            case 0:
                sectionData = getStudentsFromGrade(grade: .A) as NSArray
            case 1:
                sectionData = getStudentsFromGrade(grade: .B) as NSArray
            case 2:
                sectionData = getStudentsFromGrade(grade: .C) as NSArray
            case 3:
                sectionData = getStudentsFromGrade(grade: .D) as NSArray
            default:
                print("Default Switch Condition")
            }
            
            if (sectionData.count == 0) {
                self.expandedSectionHeaderNumber = -1;
                return;
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    imageView.transform = CGAffineTransform(rotationAngle: (180.0 * CGFloat(Double.pi)) / 180.0)
                })
                var indexesPath = [IndexPath]()
                for i in 0 ..< sectionData.count {
                    let index = IndexPath(row: i, section: section)
                    indexesPath.append(index)
                }
                self.expandedSectionHeaderNumber = section
                self.tblView!.beginUpdates()
                self.tblView!.insertRows(at: indexesPath, with: UITableView.RowAnimation.fade)
                self.tblView!.endUpdates()
            }
        }

}
