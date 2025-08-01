//
// Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation

struct RewardViewModel: Identifiable {
    let id: String
    let name: String
    let cost: Int
    let imageUrl: URL?
    var state: CardState 
}
