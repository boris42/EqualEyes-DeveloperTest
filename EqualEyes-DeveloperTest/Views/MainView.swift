//
//  ContentView.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 23/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

func IsDevelopment() -> String {
    guard let val =  Bundle.main.infoDictionary?["IsDevelopment"] as? Bool else { return " - ERR" }
    return val ? " - DEV" : " - PROD"
}

struct MainView: View {
    @ObservedObject var teachersVM: TeachersFetcher = TeachersFetcher()
    @ObservedObject var studentsVM: StudentsFetcher = StudentsFetcher()
    var body: some View {
        TabView {
            TeachersList(vm: teachersVM)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("teachers")
            }
            StudentsList(vm: studentsVM)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("students")
            }
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
