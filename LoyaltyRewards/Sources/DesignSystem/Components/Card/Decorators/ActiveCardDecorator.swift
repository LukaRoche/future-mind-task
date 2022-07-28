//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

struct ActiveCardDecorator {
    static func decorate(_ view: CardView) {
        view.backgroundColor = AppColor.cardActiveBackground
        view.imageOverlayColor = AppColor.cardActiveImageOverlay

        view.titleFont = .applicationFont(ofSize: .m, trait: DefaultFontTrait.bold)
        view.titleColor = AppColor.cardActiveTitle

        ActiveButtonDecorator.decorate(view.button)
    }
}
