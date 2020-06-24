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
            ScrollView {
                Divider()
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 10, trailing: 0 ))
                VStack(spacing:10) {
                    ForEach (vm.teachers) { teacher in
                        NavigationLink(destination: TeacherDetail(teacher: teacher)) {
                            TeacherRow(teacher: teacher)
                                .frame(maxWidth: .infinity, maxHeight: 150)
                        }
                        .navigationBarTitle(Text("teachers".localized+IsDevelopment()))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
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
