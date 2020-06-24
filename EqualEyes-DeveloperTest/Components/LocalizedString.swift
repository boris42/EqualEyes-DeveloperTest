//
//  LocalizedString.swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
