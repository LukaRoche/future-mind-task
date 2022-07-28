//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Combine

protocol DashboardViewModelProtocol: AnyObject {
    var customerName: AnyPublisher<String, Never> { get }
    var points: AnyPublisher<UInt, Never> { get }
}
