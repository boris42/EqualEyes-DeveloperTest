//
//  StudentsVM.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import Foundation

final class StudentsFetcher: ObservableObject {
    @Published var students : [Student] = []

    func loadAllStudents() {
        guard let url = URL(string: Student.APIUrl) else {
            print("error url: \(#file)@\(#line)")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("error data: \(#file)@\(#line)")
                return }
            guard let decoded = try? JSONDecoder().decode([Student].self, from: data) else {
                print("error decode: \(#file)@\(#line)")
                return }
            DispatchQueue.main.async {
                self.students = decoded
                for idx in 0..<self.students.count {
                    self.loadStudentInfo(index: idx)
                    self.loadSchoolInfo(index: idx)
                }
            }
        }.resume()
    }
    
    func loadStudentInfo(index: Int) {
        let student = self.students[index]
        guard let url = URL(string: Student.APIUrl+String(student.id)) else {
            print("error url: \(#file)@\(#line)")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("error data: \(#file)@\(#line)")
                return }
            guard let decoded = try? JSONDecoder().decode(ExtraInfo.self, from: data) else {
                print("error decode: \(#file)@\(#line) for \(data)")
                return }
            DispatchQueue.main.async {
                self.students[index].about = decoded.description
            }
        }.resume()
    }
    
    func loadSchoolInfo(index: Int) {
        let student = self.students[index]
        guard let url = URL(string: School.APIUrl+String(student.schoolId)) else {
            print("error url: \(#file)@\(#line)")
            return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("error data: \(#file)@\(#line)")
                return }
            guard let decoded = try? JSONDecoder().decode(School.self, from: data) else {
                print("error decode: \(#file)@\(#line)")
                return }
            DispatchQueue.main.async {
                self.students[index].school = decoded
            }
        }.resume()
    }
    func loadSampleData() {
        self.students = [
            Student(id: 1, name: "Patrick Doyle", schoolId: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), grade: 1, about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate."),
            Student(id: 2, name: "Nicole Cho", schoolId: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), grade: 2, about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate.")
        ]
    }
}
