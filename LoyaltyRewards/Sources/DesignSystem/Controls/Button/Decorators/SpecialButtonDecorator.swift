//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

struct SpecialButtonDecorator {
    static func decorate(_ view: Button) {
        view.font = .applicationFont(ofSize: .m, trait: DefaultFontTrait.bold)

        view.set(textColor: AppColor.buttonSpecialText, for: .normal)

        let normalGradientColors = [
            AppColor.gradientPrimaryStart.cgColor,
            AppColor.gradientPrimaryEnd.cgColor
        ]
        let highligtedGradientColors = [
            AppColor.gradientPrimaryStart.withAlphaComponent(0.5).cgColor,
            AppColor.gradientPrimaryEnd.withAlphaComponent(0.5).cgColor
        ]

        view.set(backgroundGradientColors: [
            .normal: normalGradientColors,
            .highlighted: highligtedGradientColors
        ])
    }
}
