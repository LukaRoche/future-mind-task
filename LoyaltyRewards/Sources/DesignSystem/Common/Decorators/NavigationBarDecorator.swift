//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

struct NavigationBarDecorator {
    private enum Constants {
        static let fontSize: FontSize = .m
        static let kerning: CGFloat = 0.0
        static let tintColor = AppColor.navigationBarTint
    }

    static func decorate(navigationBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColor.navigationBarBackground

        let titleFont = Font.applicationFont(
            ofSize: Constants.fontSize,
            trait: DefaultFontTrait.semibold,
            kerning: Constants.kerning
        )

        appearance.titleTextAttributes = [
            .font: titleFont.font,
            .kern: titleFont.kerning,
            .foregroundColor: Constants.tintColor
        ]

        appearance.buttonAppearance = barButtonAppearance()
        appearance.backButtonAppearance = barButtonAppearance()
        appearance.doneButtonAppearance = barButtonAppearance()

        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = Constants.tintColor

        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = appearance
        }
    }
}

extension NavigationBarDecorator {
    private static func barButtonAppearance() -> UIBarButtonItemAppearance {
        let buttonAppearance = UIBarButtonItemAppearance()

        let itemFont = Font.applicationFont(
            ofSize: Constants.fontSize,
            trait: DefaultFontTrait.regular
        )
        let itemAttributes: [NSAttributedString.Key: Any] = [
            .font: itemFont.font,
            .kern: itemFont.kerning,
            .foregroundColor: Constants.tintColor
        ]

        buttonAppearance.normal.titleTextAttributes = itemAttributes
        buttonAppearance.focused.titleTextAttributes = itemAttributes
        buttonAppearance.highlighted.titleTextAttributes = itemAttributes
        buttonAppearance.disabled.titleTextAttributes = itemAttributes

        return buttonAppearance
    }
}
