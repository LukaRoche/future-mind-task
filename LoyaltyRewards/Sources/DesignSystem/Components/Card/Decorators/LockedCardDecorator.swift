//
// Copyright © 2022 Future Mind. All rights reserved.
//

struct LockedCardDecorator {
    static func decorate(_ view: CardView) {
        view.backgroundColor = AppColor.cardLockedBackground
        view.imageOverlayColor = AppColor.cardLockedImageOverlay

        view.titleFont = .applicationFont(ofSize: .m, trait: DefaultFontTrait.bold)
        view.titleColor = AppColor.cardLockedTitle

        LockedButtonDecorator.decorate(view.button)
    }
}
