//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class DashboardCoordinator: Coordinator {
    private let dashboardFactory: DashboardProducing

    private lazy var dashboardViewController: UIViewController = {
        return dashboardFactory.makeDashboardViewController()
    }()

    override var initialViewController: UIViewController {
        return dashboardViewController
    }

    init(dashboardFactory: DashboardProducing) {
        self.dashboardFactory = dashboardFactory
    }
}
