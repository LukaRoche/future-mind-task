//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class DashboardFactory: DashboardProducing {
    func makeDashboardViewController() -> UIViewController {
        let view = DashboardViewFactory().make()
        let viewModel = DashboardViewModel()
        
        return DashboardViewController(
            view: view,
            viewModel: viewModel,
            dashboardFactory: self
        )
    }
    
    func makeErrorViewController(error: Error) -> UIViewController {
        let alertController = UIAlertController(
            title: Localized.errorAlertTitle,
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: Localized.errorAlertCloseButtonTitle, style: .default)
        alertController.addAction(action)
        
        return alertController
    }
}
