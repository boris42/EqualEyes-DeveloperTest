//
//  TeacherRow.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct TeacherRow: View {
    var teacher : Teacher
    @State private var showingSheet = false
    init(teacher: Teacher) {
        UITableView.appearance().separatorStyle = .none
        self.teacher = teacher
    }
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            URLImage(url: teacher.imageUrl)
                .aspectRatio(contentMode: .fill)
                .frame(width: 88, height: 110, alignment: .center)
                .clipped()
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(teacher.name)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.right")
                        .padding(10)
                    
                }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 15 ))
                HStack {
                    Text("class")
                    Text(teacher.className)
                }.font(.caption)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 15 ))
                HStack {
                    Spacer()
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Text("contact")
                            .font(.caption)
                            .frame(maxWidth: 80, alignment: .center)
                            .padding(EdgeInsets(top: 7, leading: 15, bottom: 7, trailing: 15 ))
                            .background(Color.darkBlue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 7, trailing: 20 ))
                .actionSheet(isPresented: $showingSheet) {
                    ActionSheet(title: Text("contact"),
                                buttons: [.default(Text("email")),
                                          .default(Text("message")),
                                          .default(Text("call")),
                                          .cancel()])
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)            
        }
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(Color.offWhite)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10 ))
        .shadow(color: Color.gray.opacity(0.5), radius: 7, x: 7, y: 7)
    }
}

struct TeacherRow_Previews: PreviewProvider {
    static let aTeacher = Teacher(id: 1, name: "John Doe", imageUrl: "https://randomuser.me/api/portraits/men/40.jpg", className: "Physics", schoolId: 2, school: School(id: 3, name: "University of Portland", imageUrl: "https://images.freeimages.com/images/large-previews/d1e/school-facade-1230710.jpg"), about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate.")
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            TeacherRow(teacher: aTeacher)
                .environment(\.locale, .init(identifier: locale))
        }
    }
}
