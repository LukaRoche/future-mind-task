//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit
import RewardsAPI

protocol DashboardProducing {
    func makeDashboardViewController() -> UIViewController
    func makeErrorViewController(error: Error) -> UIViewController
}
