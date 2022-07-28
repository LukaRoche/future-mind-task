//
// Copyright © 2022 Future Mind. All rights reserved.
//

final class AppMainFactory {}

extension AppMainFactory: AppMainProducing {
    func makeDashboardCoordinator() -> CoordinatorProtocol {
        let dashboardFactory = DashboardFactory()

        return DashboardCoordinator(dashboardFactory: dashboardFactory)
    }
}
