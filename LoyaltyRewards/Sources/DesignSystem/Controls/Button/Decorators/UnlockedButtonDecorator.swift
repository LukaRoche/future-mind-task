//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation

struct UnlockedButtonDecorator {
    static func decorate(_ view: Button) {
        view.font = .applicationFont(ofSize: .s, trait: DefaultFontTrait.bold)

        view.set(textColor: AppColor.buttonUnlockedText, for: .normal)

        view.icon = Asset.padlockUnlocked.image

        let normalGradientColors = [
            AppColor.buttonUnlockedBackground.cgColor,
            AppColor.buttonUnlockedBackground.cgColor
        ]
        let highligtedGradientColors = [
            AppColor.buttonUnlockedBackground.withAlphaComponent(0.5).cgColor,
            AppColor.buttonUnlockedBackground.withAlphaComponent(0.5).cgColor
        ]

        view.set(backgroundGradientColors: [
            .normal: normalGradientColors,
            .highlighted: highligtedGradientColors
        ])
    }
}
