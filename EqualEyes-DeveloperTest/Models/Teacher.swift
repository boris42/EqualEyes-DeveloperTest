//
//  Teacher.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

struct Teacher : Decodable, Identifiable {
    let id: Int
    var name: String
    var imageUrl : String
    let className : String
    let schoolId : Int
    var school : School? = nil
    var about : String? = nil
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case schoolId = "school_id"
        case className = "class"
        case imageUrl = "image_url"
    }
    init(id: Int, name: String, imageUrl: String, className: String, schoolId: Int, school: School? = nil, about: String? = nil) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.className = className
        self.schoolId = schoolId
    }
    init(teacher: Teacher, school: School) {
        self = teacher
        self.school = school
    }
    init(teacher: Teacher, description: String) {
        self = teacher
        self.about = description
    }
    static let APIUrl : String = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/"
}
