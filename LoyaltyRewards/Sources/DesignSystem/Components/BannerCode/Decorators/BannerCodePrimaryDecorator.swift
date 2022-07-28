//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation

struct BannerCodePrimaryDecorator {
    static func decorate(_ view: BannerCodeView) {
        view.titleFont = .applicationFont(ofSize: .m, trait: DefaultFontTrait.bold)
        view.messageFont = .applicationFont(ofSize: .s, trait: DefaultFontTrait.semibold)

        view.titleColor = AppColor.bannerCodeTitle
        view.messageColor = AppColor.bannerCodeMessage

        view.gradientColors = [
            AppColor.gradientSecondaryStart.cgColor,
            AppColor.gradientSecondaryEnd.cgColor
        ]
        view.gradientLocations = [0.0342, 0.8432]

        SpecialButtonDecorator.decorate(view.shareButton)
    }
}
