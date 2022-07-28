//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

extension NSAttributedString {
    convenience init?(string: String?, font: Font) {
        guard let string = string else {
            return nil
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font.font,
            .kern: font.kerning
        ]

        self.init(
            string: string,
            attributes: attributes
        )
    }

    func adding(font: Font) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font.font,
            .kern: font.kerning
        ]

        let mutableString = NSMutableAttributedString(attributedString: self)
        let range = NSRange(
            location: 0,
            length: mutableString.length
        )
        mutableString.addAttributes(attributes, range: range)

        return mutableString
    }
}
