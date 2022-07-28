//
//  Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

class Coordinator: CoordinatorProtocol {
    private weak var _rootViewController: UIViewController?

    var initialViewController: UIViewController {
        fatalError("Initial view controller is not implemented")
    }

    private(set) lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()

        NavigationBarDecorator.decorate(navigationBar: navigationController.navigationBar)

        return navigationController
    }()

    var didFinish: ((CoordinatorProtocol) -> Void)?

    private var childCoordinators: [String: CoordinatorProtocol] = [:]

    init() {}

    func start() {
        navigationController.pushViewController(initialViewController, animated: true)
    }

    func start(coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.name] = coordinator
        coordinator.start()
    }

    func removeChild(_ coordinator: CoordinatorProtocol) {
        childCoordinators[coordinator.name] = nil
    }
}
