//
//  TeachersList.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct TeachersList: View {
    @ObservedObject var vm : TeachersFetcher
    var body: some View {
        NavigationView {
            List {
                ForEach (vm.teachers) { teacher in
                    Text(teacher.name)
                }
            }.navigationBarTitle(Text("teachers".localized+IsDevelopment()))
         
        }
        .onAppear(perform: {self.vm.loadSampleData()})
    }
}

struct TeachersList_Previews: PreviewProvider {
    static var tf = TeachersFetcher()
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            TeachersList(vm: tf)
                .environment(\.locale, .init(identifier: locale))
            .onAppear(perform: { tf.loadSampleData() })
        }
    }
}
