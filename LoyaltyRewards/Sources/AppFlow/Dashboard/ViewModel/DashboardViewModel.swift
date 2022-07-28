//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Combine

final class DashboardViewModel {
    @Published private var customerNamePublisher: String = ""
    @Published private var availablePointsPublisher: UInt = 0
}

extension DashboardViewModel: DashboardViewModelProtocol {
    var customerName: AnyPublisher<String, Never> {
        return $customerNamePublisher.eraseToAnyPublisher()
    }

    var points: AnyPublisher<UInt, Never> {
        return $availablePointsPublisher.eraseToAnyPublisher()
    }
}
