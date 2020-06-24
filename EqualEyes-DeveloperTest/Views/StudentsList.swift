//
//  StudentsList.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import SwiftUI

struct StudentsList: View {
    @ObservedObject var vm : StudentsFetcher

    var body: some View {
        NavigationView {
            List {
                ForEach (vm.students) { student in
                    Text(student.name)
                }
            }.navigationBarTitle(Text("students".localized+IsDevelopment()))
        }
        .onAppear(perform: {self.vm.loadSampleData()})
    }
}

struct StudentsList_Previews: PreviewProvider {
    static var sf = StudentsFetcher()
    static var previews: some View {
        ForEach(["en","fr"], id: \.self) { locale in
            StudentsList(vm: sf)
                .environment(\.locale, .init(identifier: locale))
                .onAppear(perform: { sf.loadSampleData() })
        }
    }
}
