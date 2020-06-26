//
//  TeachersVM.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import Foundation
import Combine

final class TeachersFetcher: ObservableObject {
    @Published var teachers : [Teacher] = []
    
    private var dataLoader : AnyCancellable!
    
    deinit {
        dataLoader.cancel()
    }
    
    func loadData() {
        if teachers.isEmpty {
            if let url = URL(string: Teacher.APIUrl) {
                dataLoader = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: [Teacher].self, decoder: JSONDecoder())
                    .assertNoFailure()
                    .flatMap { $0.publisher }
                    .flatMap { teacher in
                        URLSession.shared.dataTaskPublisher(for: URL(string: School.APIUrl+String(teacher.schoolId))!)
                            .map { $0.data}
                            .decode(type: School.self, decoder: JSONDecoder())
                            .catch {_ in
                                Just(School(id: teacher.schoolId, name: "", imageUrl: ""))
                        }
                        .map { school in
                            Teacher(teacher: teacher, school: school)
                        }
                }
                .flatMap { teacher in
                    URLSession.shared.dataTaskPublisher(for: URL(string: Teacher.APIUrl+String(teacher.id))!)
                        .map { $0.data}
                        .decode(type: ExtraInfo.self, decoder: JSONDecoder())
                        .catch {_ in
                            Just(ExtraInfo(id: teacher.id, description: ""))
                    }
                    .map { info in
                        Teacher(teacher: teacher, description: info.description)
                    }
                }
                .collect()
                .receive(on: RunLoop.main)
                .assign(to: \.teachers, on: self)
            }
        }
    }
    
    func loadSampleData() {
        self.teachers = [
            Teacher(id: 1, name: "John Doe", imageUrl: "https://randomuser.me/api/portraits/men/40.jpg", className: "Physics", schoolId: 1, school: School(id: 1, name: "Bern community college", imageUrl: "https://images.freeimages.com/images/large-previews/d1e/school-facade-1230710.jpg"), about: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vehicula, lectus vitae vestibulum tristique, quam nisi elementum metus, a venenatis ante sem quis sapien. Duis tempor sapien at nibh ultrices, sed aliquam magna fermentum. Ut eleifend porta neque ut vulputate."),
            Teacher(id: 2, name: "Emily Parker", imageUrl: "https://randomuser.me/api/portraits/women/42.jpg", className: "History", schoolId: 2, school: School(id: 2, name: "Royal College of Art", imageUrl: "https://cdn.pixabay.com/photo/2014/05/02/23/52/castle-336498_1280.jpg"), about: "Donec et lorem nec ex sodales sodales. Cras tempor ultrices felis, nec posuere dolor gravida imperdiet. Mauris congue tellus id ultricies pulvinar. Vivamus eleifend turpis nunc, quis aliquam purus lobortis sit amet. Vivamus vel dignissim velit. Donec varius rhoncus feugiat. Donec vehicula non massa quis lacinia.")]
    }
}
