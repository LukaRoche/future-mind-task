//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Combine
import RewardsAPI
import Foundation

final class DashboardViewModel {
    @Published private var customerNamePublisher: String = ""
    @Published private var availablePointsPublisher: Int = 0
    @Published private var rewardsPublisher: [RewardViewModel] = []
    @Published private var isLoadingPublisher: Bool = false
    @Published private var errorPublisher: Error? = nil
    
    private var cancellables: Set<AnyCancellable> = []
}

extension DashboardViewModel: DashboardViewModelProtocol {
    var customerName: AnyPublisher<String, Never> {
        return $customerNamePublisher.eraseToAnyPublisher()
    }
    
    var points: AnyPublisher<Int, Never> {
        return $availablePointsPublisher.eraseToAnyPublisher()
    }
    
    var rewards: AnyPublisher<[RewardViewModel], Never> {
        return $rewardsPublisher.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool, Never> {
        return $isLoadingPublisher.eraseToAnyPublisher()
    }
    
    var error: AnyPublisher<Error, Never> {
        return $errorPublisher.compactMap { $0 }.eraseToAnyPublisher()
    }
    
    func fetchData() {
        guard !isLoadingPublisher else { return }
        isLoadingPublisher = true
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let customerPublisher = API.shared.loadCustomer()
        let pointsPublisher = API.shared.loadAvailablePoints()
        let rewardsPublisher = API.shared.loadRewards()
        let activeRewardsPublisher = API.shared.getActiveRewardIdentifiers()
        
        Publishers.Zip4(customerPublisher, pointsPublisher, rewardsPublisher, activeRewardsPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingPublisher = false
                if case let .failure(error) = completion {
                    self?.errorPublisher = error
                }
            } receiveValue: { [weak self] (customer, points, rewards, activeRewardIds) in
                guard let self = self else { return }
                
                self.customerNamePublisher = customer.name
                self.availablePointsPublisher = Int(points)
                
                self.rewardsPublisher = rewards.map { reward in
                    let isActive = activeRewardIds.contains(reward.id)
                    
                    let state: CardState
                    if isActive {
                        state = .active
                    } else if Int(points) >= reward.pointsCost {
                        state = .unlocked
                    } else {
                        state = .locked
                    }
                    
                    return RewardViewModel(
                        id: reward.id,
                        name: reward.name,
                        cost: reward.pointsCost,
                        imageUrl: reward.coverURL,
                        state: state
                    )
                }
            }
            .store(in: &cancellables)
    }

    func handleRewardAction(for rewardId: String) {
        guard !isLoadingPublisher else { return }
        isLoadingPublisher = true
        
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        let rewardPublisher: AnyPublisher<Void, Error>

        if let currentReward = rewardsPublisher.first(where: { $0.id == rewardId }) {
            if currentReward.state == .active {
                rewardPublisher = API.shared.deactivateReward(with: rewardId).eraseToAnyPublisher()
            } else {
                rewardPublisher = API.shared.activateReward(with: rewardId).eraseToAnyPublisher()
            }
        } else {
            return
        }

        rewardPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoadingPublisher = false
                if case let .failure(error) = completion {
                    self?.errorPublisher = error
                } else {
                    self?.fetchData()
                }
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
