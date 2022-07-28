//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

struct SectionTitlePrimaryDecorator {
    static func decorate(_ view: SectionTitleView) {
        view.titleFont = .applicationFont(ofSize: .xl, trait: DefaultFontTrait.bold)
        view.titleColor = AppColor.sectionTitleTitle

        view.subtitleFont = .applicationFont(ofSize: .m, trait: DefaultFontTrait.regular)
        view.subtitleColor = AppColor.sectionTitleSubtitle
    }
}
