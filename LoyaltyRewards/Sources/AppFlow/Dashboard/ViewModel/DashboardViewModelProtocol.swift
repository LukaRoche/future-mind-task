//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Combine
import Foundation

protocol DashboardViewModelProtocol: AnyObject {
    var customerName: AnyPublisher<String, Never> { get }
    var points: AnyPublisher<Int, Never> { get }
    var rewards: AnyPublisher<[RewardViewModel], Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var error: AnyPublisher<Error, Never> { get }
    
    func fetchData()
    func activateReward(id: String)
    func deactivateReward(id: String)
    func handleRewardAction(for rewardId: String)
}
