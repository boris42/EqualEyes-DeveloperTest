//
//  ContentView.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 23/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

func IsDevelopment() -> String {
    guard let val =  Bundle.main.infoDictionary?["IsDevelopment"] as? Bool else { return "" }
    return val ? " - DEV" : ""
}

struct MainView: View {
    @ObservedObject var teachersVM: TeachersFetcher = TeachersFetcher()
    @ObservedObject var studentsVM: StudentsFetcher = StudentsFetcher()
    
    var body: some View {
        UIKitTabView {
            TeachersList(vm: teachersVM)
                .tab(title: "teachers", image: "person.circle", selectedImage: "person.circle.fill")
            StudentsList(vm: studentsVM)
                .tab(title: "students", image: "person.3", selectedImage: "person.3.fill")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            MainView()
                .environment(\.locale, .init(identifier: locale))
        }
    }
}
