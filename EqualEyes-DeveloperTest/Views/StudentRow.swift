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
    init(student: Student) {
        UITableView.appearance().separatorStyle = .none
        self.student = student
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(student.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.right")
                    .padding(10)
            }.padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 15 ))
            HStack {
                Text("grade")
                Text(String(student.grade))
            }
            .font(.caption)
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 10, trailing: 15 ))
        }
        .background(Color.offWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10 ))
        .shadow(color: Color.gray.opacity(0.5), radius: 7, x: 7, y: 7)
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
