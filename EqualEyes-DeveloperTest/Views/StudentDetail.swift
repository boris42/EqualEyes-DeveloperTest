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
            VStack(alignment: .center, spacing: 5) {
                GeometryReader { geo in
                    HStack(alignment: .top) {
                        URLImage(url: self.student.school?.imageUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geo.size.height)
                            .clipped()
                    }
                    .frame(maxHeight: .infinity)
                }
                HStack(alignment: .center) {
                    Text(student.name)
                        .font(.headline)
                        .frame(alignment: .leading)
                    VStack(alignment: .trailing, spacing: 7) {
                        HStack {
                            Text("grade")
                            Text(String(student.grade))
                        }
                    }
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20 ))
                Divider()
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0 ))
                Group {
                    Text("about")
                        .font(.headline)
                    Text(student.about ?? "")
                        .font(.footnote)
                        .frame(minHeight: 80, alignment: .top)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20 ))
            }
            .background(Color.offWhite)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: Color.gray.opacity(0.5), radius: 7, x: 7, y: 7)
            .padding(15)
            .navigationBarTitle("details", displayMode: .inline)
            Spacer()
                .frame(height: 40)
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
