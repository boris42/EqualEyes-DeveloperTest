//
//  TeacherDetail.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct TeacherDetail: View {
    @State private var showingSheet = false
    var teacher: Teacher
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 5) {
                GeometryReader { geo in
                    HStack(alignment: .top) {
                        URLImage(url: self.teacher.school?.imageUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geo.size.height)
                            .clipped()
                    }
                    .frame(maxHeight: .infinity)
                }
                HStack(alignment: .top) {
                    Text(teacher.name)
                        .font(.headline)
                        .frame(alignment: .leading)
                    VStack(alignment: .trailing, spacing: 7) {
                        HStack {
                            Text("class")
                            Text(teacher.className)
                        }
                        HStack {
                            Text("school")
                            Text(teacher.school?.name ?? "")
                        }
                    }
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20 ))
                Divider()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0 ))
                Group {
                    Text("about")
                        .font(.headline)
                    Text(teacher.about ?? "")
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
            Button(action: {
                self.showingSheet = true
            }) {
                Text("contact")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0 ))
                    .background(Color.darkBlue)
                    .foregroundColor(Color.white)
                    .cornerRadius(15)
            }
            .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10 ))
            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("contact"),
                            buttons: [.default(Text("email")),
                                      .default(Text("message")),
                                      .default(Text("call")),
                                      .cancel()])
            }
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
