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

struct ContentView: View {
    var body: some View {
        Text("Hello, World!"+IsDevelopment())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
