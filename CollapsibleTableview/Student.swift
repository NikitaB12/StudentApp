//
//  Students.swift
//  CollapsibleTableview
//
//  Created by Nikita Vilas Barhate on 01/09/21.
//

import Foundation

enum Grade : String, CaseIterable {
    case A = "Grade A"
    case B = "Grade B"
    case C = "Grade C"
    case D = "Grade D"
}

class Student {
    var name : String!
    var roll_no : Int!
    var grade : Grade!
    
    init(name : String, roll_no : Int, grade : Grade) {
        self.name = name
        self.roll_no = roll_no
        self.grade = grade
        
    }
}
