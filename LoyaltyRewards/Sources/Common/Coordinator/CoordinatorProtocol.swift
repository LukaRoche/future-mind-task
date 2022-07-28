//
//  Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: AnyObject, ClassNameProtocol {
    var navigationController: UINavigationController { get }
    var didFinish: ((CoordinatorProtocol) -> Void)? { get set }

    func start()
}
