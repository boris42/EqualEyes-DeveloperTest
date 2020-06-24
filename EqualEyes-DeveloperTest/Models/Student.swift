//
//  Student.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

struct Student : Decodable, Identifiable {
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
    
    static let APIUrl : String = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students/"
}
