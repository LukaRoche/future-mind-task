//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation
import UIKit
import RewardsAPI
import Combine

struct CardViewDecorator {
    
    private var cancellables: Set<AnyCancellable> = []
    
    static func decorate(_ cardView: CardView, with viewModel: RewardViewModel) {
        cardView.viewModel = viewModel
        cardView.title = viewModel.name
        cardView.button.text = Localized.cardPointsButton(viewModel.cost)
        cardView.loadImage(from: viewModel.imageUrl)
        
        switch viewModel.state {
        case .active:
            ActiveCardDecorator.decorate(cardView)
            cardView.button.isEnabled = true
        case .locked:
            LockedCardDecorator.decorate(cardView)
            cardView.button.isEnabled = false
        case .unlocked:
            UnlockedCardDecorator.decorate(cardView)
            cardView.button.isEnabled = true
        }
    }
}
