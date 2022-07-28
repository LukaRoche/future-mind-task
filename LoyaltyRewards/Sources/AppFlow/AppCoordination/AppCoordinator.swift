//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow
    private let appMainFactory: AppMainProducing

    init(window: UIWindow, appMainFactory: AppMainProducing) {
        self.window = window
        self.appMainFactory = appMainFactory

        window.makeKeyAndVisible()

        super.init()
    }

    override func start() {        
        startDashboard()
    }
}

extension AppCoordinator {
    private func startDashboard() {
        let coordinator = appMainFactory.makeDashboardCoordinator()
        coordinator.didFinish = { [weak self] coordinator in
            self?.removeChild(coordinator)
        }

        start(coordinator: coordinator)
        window.rootViewController = coordinator.navigationController
    }
}
