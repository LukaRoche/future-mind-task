//
//  Copyright © 2022 Future Mind. All rights reserved.
//

import Foundation

protocol ClassNameProtocol {
    static var name: String { get }
    var name: String { get }
}

extension ClassNameProtocol {
    static var name: String {
        return String(describing: self)
    }

    var name: String {
        return Self.name
    }
}

extension NSObject: ClassNameProtocol {}
