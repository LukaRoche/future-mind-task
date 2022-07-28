//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation

struct LockedButtonDecorator {
    static func decorate(_ view: Button) {
        view.font = .applicationFont(ofSize: .s, trait: DefaultFontTrait.bold)

        view.set(textColor: AppColor.buttonLockedText, for: .normal)

        view.icon = Asset.padlockLocked.image

        let normalGradientColors = [
            AppColor.buttonLockedBackground.cgColor,
            AppColor.buttonLockedBackground.cgColor
        ]
        let highligtedGradientColors = [
            AppColor.buttonLockedBackground.withAlphaComponent(0.5).cgColor,
            AppColor.buttonLockedBackground.withAlphaComponent(0.5).cgColor
        ]

        view.set(backgroundGradientColors: [
            .normal: normalGradientColors,
            .highlighted: highligtedGradientColors
        ])
    }
}
