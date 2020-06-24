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
    var body: some View {
        VStack {
            Group{
                Text("Hello, World!"+IsDevelopment())
                Text("teachers")
                Text("students")
                Text("class")
                Text("school")
                Text("contact")
            }
            Group {
                Text("email")
                Text("message")
                Text("call")
                Text("about")
                Text("grade")
                Text("details")
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
