//
//  StudentsVM.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import Foundation
import Combine

final class StudentsFetcher: ObservableObject {
    @Published var students : [Student] = []
    
    private var dataLoader : AnyCancellable!
    
    deinit {
        dataLoader.cancel()
    }
    
    func loadData() {
        if students.isEmpty {
            if let url = URL(string: Student.APIUrl) {
                dataLoader = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: [Student].self, decoder: JSONDecoder())
                    .assertNoFailure()
                    .flatMap { $0.publisher }
                    .flatMap { student in
                        URLSession.shared.dataTaskPublisher(for: URL(string: School.APIUrl+String(student.schoolId))!)
                            .map { $0.data}
                            .decode(type: School.self, decoder: JSONDecoder())
                            .catch {_ in
                                Just(School(id: student.schoolId, name: "", imageUrl: ""))
                        }
                        .map { school in
                            Student(student: student, school: school)
                        }
                }
                .flatMap { student in
                    URLSession.shared.dataTaskPublisher(for: URL(string: Student.APIUrl+String(student.id))!)
                        .map { $0.data}
                        .decode(type: ExtraInfo.self, decoder: JSONDecoder())
                        .catch {_ in
                            Just(ExtraInfo(id: student.id, description: ""))
                    }
                    .map { info in
                        Student(student: student, description: info.description)
                    }
                }
                .collect()
                .receive(on: RunLoop.main)
                .assign(to: \.students, on: self)
            }
        }
    }
    
    func loadSampleData() {
        self.students = [
            Student(id: 1, name: "Patrick Doyle", schoolId: 1, grade: 1, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate."),
            Student(id: 2, name: "Nicole Cho", schoolId: 1, grade: 2, school: School(id: 1, name: "JFK high school", imageUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/John_F._Kennedy_High_School.jpg/440px-John_F._Kennedy_High_School.jpg"), about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate.")
        ]
    }
}
