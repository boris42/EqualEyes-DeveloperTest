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
             ScrollView {
                 Divider()
                     .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0 ))
                 VStack(spacing:10) {
                    ForEach (vm.students) { student in
                         NavigationLink(destination: StudentDetail(student: student)) {
                             StudentRow(student: student)
                                 .frame(maxWidth: .infinity, maxHeight: 150)
                         }
                         .navigationBarTitle(Text("students".localized+IsDevelopment()))
                     }
                     .buttonStyle(PlainButtonStyle())
                 }
             }
         }
         .onAppear(perform: {self.vm.loadAllStudents()})
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
