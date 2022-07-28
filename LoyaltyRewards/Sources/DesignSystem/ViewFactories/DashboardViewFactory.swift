//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

struct DashboardViewFactory {
    func make() -> DashboardView {
        let view = DashboardView()

        view.backgroundColor = AppColor.backgroundPrimary
        view.backgroundGradientView.colors = [
            AppColor.gradientBackgroundStart.cgColor,
            AppColor.gradientBackgroundEnd.cgColor
        ]
        view.backgroundGradientView.locations = [-0.07, 0.22]

        view.sectionTitle.subtitle = Localized.dashboardWelcomeSubtitle
        view.sectionTitle.icon = Asset.card.image

        SectionTitlePrimaryDecorator.decorate(view.sectionTitle)

        view.counterLoop.pointsSuffix = Localized.dashboardPointsSuffix
        view.counterLoop.subtitle = Localized.dashboardReedemPointsMessage
        view.counterLoop.icon = Asset.loop.image

        CounterLoopPrimaryDecorator.decorate(view.counterLoop)

        view.bannerCode.title = Localized.dashboardBottomBannerTitle
        view.bannerCode.message = Localized.dashboardBottomBannerMessage
        view.bannerCode.shareButton.text = Localized.dashboardBottomBannerButtonTitle

        BannerCodePrimaryDecorator.decorate(view.bannerCode)

        RefreshControlDecorator.decorate(view.refreshControl)

        return view
    }
}
