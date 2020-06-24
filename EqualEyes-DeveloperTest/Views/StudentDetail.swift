//
//  StudentDetail.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct StudentDetail: View {
    var student: Student
    var body: some View {
        VStack {
            Text(student.name)
            HStack {
                Text("school")
                Text(student.school?.name ?? "")
            }
            HStack {
                Text("grade")
                Text(String(student.grade))
            }
            Text(student.about ?? "")
        }
    }
}

struct StudentDetail_Previews: PreviewProvider {
    static let aStudent = Student(id: 1, name: "Patrick Doyle", schoolId: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), grade: 1, about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate.")
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            StudentDetail(student: aStudent)
                .environment(\.locale, .init(identifier: locale))
        }
    }
}
