//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func adding(color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color
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
