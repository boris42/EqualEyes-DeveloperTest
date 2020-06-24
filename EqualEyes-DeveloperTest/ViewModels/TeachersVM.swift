//
//  TeachersVM.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import Foundation

final class TeachersFetcher: ObservableObject {
    @Published var teachers : [Teacher] = []

    func loadAllTeachers() {
        guard let url = URL(string: Teacher.APIUrl) else {
            print("error url: \(#file)@\(#line)")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("error data: \(#file)@\(#line)")
                return }
            guard let decoded = try? JSONDecoder().decode([Teacher].self, from: data) else {
                print("error decode: \(#file)@\(#line)")
                return }
            DispatchQueue.main.async {
                self.teachers = decoded
                for idx in 0..<self.teachers.count {
                    self.loadTeacherInfo(index: idx)
                    self.loadSchoolInfo(index: idx)
                }
            }
        }.resume()
    }
    
    func loadTeacherInfo(index: Int) {
        let teacher = self.teachers[index]
        guard let url = URL(string: Teacher.APIUrl+String(teacher.id)) else {
            print("error url: \(#file)@\(#line)")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("error data: \(#file)@\(#line)")
                return }
            guard let decoded = try? JSONDecoder().decode(ExtraInfo.self, from: data) else {
                print("error decode: \(#file)@\(#line) for \(data)")
                return }
            DispatchQueue.main.sync {
                self.teachers[index].about = decoded.description
            }
        }.resume()
    }
    
    func loadSchoolInfo(index: Int) {
        let teacher = self.teachers[index]
        let schoolId = teacher.schoolId
        guard let url = URL(string: School.APIUrl+String(schoolId)) else {
            print("error url: \(#file)@\(#line)")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("error data: \(#file)@\(#line)")
                return }
            guard let decoded = try? JSONDecoder().decode(School.self, from: data) else {
                print("error decode: \(#file)@\(#line)")
                return }
            DispatchQueue.main.sync {
                self.teachers[index].school = decoded
            }
        }.resume()
    }
    func loadSampleData() {
        self.teachers = [
        Teacher(id: 1, name: "John Doe", imageUrl: "https://randomuser.me/api/portraits/men/40.jpg", className: "Physics", schoolId: 1, school: School(id: 1, name: "Bern community college", imageUrl: "https://images.freeimages.com/images/large-previews/d1e/school-facade-1230710.jpg"), about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate."),
        Teacher(id: 2, name: "Emily Parker", imageUrl: "https://randomuser.me/api/portraits/women/42.jpg", className: "History", schoolId: 2, school: School(id: 2, name: "Royal College of Art", imageUrl: "https://cdn.pixabay.com/photo/2014/05/02/23/52/castle-336498_1280.jpg"), about: "Donec et lorem nec ex sodales sodales. Cras tempor ultrices felis, nec posuere dolor gravida imperdiet. Mauris congue tellus id ultricies pulvinar. Vivamus eleifend turpis nunc, quis aliquam purus lobortis sit amet. Vivamus vel dignissim velit. Donec varius rhoncus feugiat. Donec vehicula non massa quis lacinia.")]
    }
}
