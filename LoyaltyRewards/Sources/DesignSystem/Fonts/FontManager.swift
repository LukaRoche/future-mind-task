//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class FontManager {
    private var applicationFontFamily = "Helvetica Neue"

    static let shared = FontManager()

    func applicationFont(
        ofSize size: CGFloat,
        trait: FontTrait = DefaultFontTrait.regular,
        kerning: CGFloat = 0
    ) -> Font {
        let descriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.family: applicationFontFamily,
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: trait.weight,
                UIFontDescriptor.TraitKey.slant: trait.slant
            ]
        ])
        return Font(
            font: UIFont(descriptor: descriptor, size: size),
            kerning: kerning
        )
    }
}
