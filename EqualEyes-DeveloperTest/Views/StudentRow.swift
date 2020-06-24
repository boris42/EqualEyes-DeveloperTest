//
//  StudentRow.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct StudentRow: View {
    var student : Student

    var body: some View {
        VStack {
            Text(student.name)
            HStack {
                Text("class")
                Text(String(student.grade))
            }
        }
    }
}

struct StudentRow_Previews: PreviewProvider {
    static let aStudent = Student(id: 1, name: "Patrick Doyle", schoolId: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), grade: 1)
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            StudentRow(student: aStudent)
                .environment(\.locale, .init(identifier: locale))
        }
    }
}
