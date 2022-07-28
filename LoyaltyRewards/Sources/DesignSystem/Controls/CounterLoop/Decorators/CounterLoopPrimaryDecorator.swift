//
// Copyright © 2022 Future Mind. All rights reserved.
//

struct CounterLoopPrimaryDecorator {
    static func decorate(_ view: CounterLoop) {
        view.pointsFont = .applicationFont(ofSize: .xl, trait: DefaultFontTrait.bold)
        view.subtitleFont = .applicationFont(ofSize: .s, trait: DefaultFontTrait.semibold)

        view.set(pointsColor: AppColor.points, for: .normal)
        view.set(subtitleColor: AppColor.counterLoopSubtitle, for: .normal)
        view.set(pointsSuffixColor: AppColor.counterLoopPointsSuffix, for: .normal)
        view.set(loaderColor: AppColor.loaderPrimary, for: .normal)
    }
}
