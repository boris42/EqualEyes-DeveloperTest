//
//  TeacherDetail.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct TeacherDetail: View {
    
    var teacher: Teacher
    var body: some View {
        VStack {
            Text(teacher.name)
            HStack {
                Text("class")
                Text(teacher.className)
            }
            HStack {
                Text("school")
                Text(teacher.school?.name ?? "")
            }
            Text(teacher.imageUrl)
            Text(teacher.about ?? "")
            
        }
        .navigationBarTitle("details", displayMode: .inline)
    }
}


struct TeacherDetail_Previews: PreviewProvider {
    static let aTeacher = Teacher(id: 1, name: "John Doe", imageUrl: "https://randomuser.me/api/portraits/men/40.jpg", className: "Physics", schoolId: 2, school: School(id: 3, name: "University of Portland", imageUrl: "http://www.os-koper.si/files/2016/11/oskoper-spredaj3.png"), about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate.")
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            TeacherDetail(teacher: aTeacher)
                .environment(\.locale, .init(identifier: locale))
        }
    }
}
