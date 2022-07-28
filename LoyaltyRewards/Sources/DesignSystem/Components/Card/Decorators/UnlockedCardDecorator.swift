//
// Copyright © 2022 Future Mind. All rights reserved.
//

struct UnlockedCardDecorator {
    static func decorate(_ view: CardView) {
        view.backgroundColor = AppColor.cardUnlockedBackground
        view.imageOverlayColor = AppColor.cardUnlockedImageOverlay

        view.titleFont = .applicationFont(ofSize: .m, trait: DefaultFontTrait.bold)
        view.titleColor = AppColor.cardUnlockedTitle

        UnlockedButtonDecorator.decorate(view.button)
    }
}
