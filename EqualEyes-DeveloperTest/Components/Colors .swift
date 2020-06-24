//
//  Colors .swift
//  EqualEyes-DeveloperTest
//
//  Created by Boris Herman on 24/06/2020.
//  Copyright © 2020 Sight&Sound s.p. All rights reserved.
//

import UIKit
import SwiftUI

extension UIColor {
    convenience init(_ value: IntegerLiteralType) {
        let r = CGFloat((value >> 16) & 0xFF) / 255;
        let g = CGFloat((value >> 8) & 0xFF) / 255;
        let b = CGFloat((value) & 0xFF) / 255;
        self.init(red : r, green : g, blue : b, alpha : 1.0)
    }
    class var offWhite : UIColor { UIColor(0xFAFAF8) }
    class var darkBlue : UIColor { UIColor(0x1C0C43)}
}

extension Color {
    static var offWhite = Color(UIColor.offWhite)
    static var darkBlue = Color(UIColor.darkBlue)
}

struct Colors_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Color(.offWhite)
            Color(.darkBlue)
        }
    }
}

