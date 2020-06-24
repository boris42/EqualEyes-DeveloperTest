//
//  School.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

struct School : Decodable, Identifiable {
    let id: Int
    let name: String
    let imageUrl : String
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
    }
    
    static let APIUrl : String = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/"
}
