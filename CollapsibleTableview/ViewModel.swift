//
//  ViewModel.swift
//  CollapsibleTableview
//
//  Created by Nikita Vilas Barhate on 01/09/21.
//

import Foundation

class ViewModel {
    
    public func getStudents() -> [Student] {
        var students : [Student] = [Student]()
        let student = Student(name: "Nikita", roll_no: 1, grade: .A)
        let student1 = Student(name: "Harshal", roll_no: 3, grade: .A)
        let student2 = Student(name: "PQR", roll_no: 6, grade: .B)
        let student3 = Student(name: "XYZ", roll_no: 2, grade: .B)
        let student4 = Student(name: "ABC", roll_no: 4, grade: .C)
        let student5 = Student(name: "PQR", roll_no: 8, grade: .C)
        let student6 = Student(name: "DEF", roll_no: 10, grade: .C)
        let student7 = Student(name: "QWERTY", roll_no: 5, grade: .D)
        let student8 = Student(name: "Shiva", roll_no: 9, grade: .D)
        let student9 = Student(name: "Vipin", roll_no: 7, grade: .D)
        students.append(student)
        students.append(student1)
        students.append(student2)
        students.append(student3)
        students.append(student4)
        students.append(student5)
        students.append(student6)
        students.append(student7)
        students.append(student8)
        students.append(student9)
        return students
    }
    
}
