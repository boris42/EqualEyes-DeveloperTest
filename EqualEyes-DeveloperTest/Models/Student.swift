//
//  Student.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

struct Student : Decodable, Identifiable, CustomDebugStringConvertible {
    let id: Int
    let name: String
    let schoolId: Int
    var school : School? = nil
    let grade : Int
    var about : String? = nil
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case schoolId = "school_id"
        case grade
    }
    init(id: Int, name: String, schoolId: Int, grade: Int, school: School? = nil, about: String? = nil) {
        self.id = id
        self.name = name
        self.schoolId = schoolId
        self.grade = grade
    }
    init(student: Student, school: School) {
          self = student
          self.school = school
      }
      init(student: Student, description: String) {
          self = student
          self.about = description
      }
    var debugDescription: String {
           "Student(id: \(id), name: \(name), grade: \(grade), schoolId: \(schoolId), school: \(String(describing: school)), about: \(about ?? "")"
       }
    static let APIUrl : String = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students/"
}
