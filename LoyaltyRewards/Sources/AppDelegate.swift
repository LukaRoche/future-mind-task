//
//  Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppCoordinator!

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let factory = AppMainFactory()
        let appCoordinator = AppCoordinator(window: window, appMainFactory: factory)
        appCoordinator.start()
        self.appCoordinator = appCoordinator

        return true
    }
}
