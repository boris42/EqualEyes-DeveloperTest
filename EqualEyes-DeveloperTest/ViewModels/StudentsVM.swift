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

    func loadSampleData() {
        self.students = [
            Student(id: 1, name: "Patrick Doyle", schoolId: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), grade: 1),
            Student(id: 2, name: "Nicole Cho", schoolId: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), grade: 2)
        ]
    }
}
