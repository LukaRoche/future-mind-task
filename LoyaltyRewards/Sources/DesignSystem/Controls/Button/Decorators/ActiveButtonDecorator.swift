//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation

struct ActiveButtonDecorator {
    static func decorate(_ view: Button) {
        view.font = .applicationFont(ofSize: .s, trait: DefaultFontTrait.bold)

        view.set(textColor: AppColor.buttonActiveText, for: .normal)

        view.icon = Asset.checkmark.image

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
