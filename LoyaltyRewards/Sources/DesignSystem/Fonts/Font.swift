//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

struct Font {
    let font: UIFont
    let kerning: CGFloat

    init(font: UIFont, kerning: CGFloat = 0) {
        self.font = font
        self.kerning = kerning
    }
}

extension Font {
    static func applicationFont(
        ofSize size: FontSize,
        trait: FontTrait,
        kerning: CGFloat = 0
    ) -> Font {
        return FontManager.shared.applicationFont(
            ofSize: size.rawValue,
            trait: trait,
            kerning: kerning
        )
    }
}
