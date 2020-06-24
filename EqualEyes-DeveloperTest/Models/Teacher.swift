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

    static let APIUrl : String = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/"
}
