//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class GradientView: UIView {
    enum Direction {
        case leftToRight
        case rightToLeft
        case bottomToTop
        case topToBottom
    }

    private var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }

    var gradientDirection: Direction = .leftToRight {
        didSet {
            if gradientDirection != oldValue {
                handleGradientDirectionUpdated()
            }
        }
    }

    var colors: [CGColor]? {
        get {
            return gradientLayer?.colors as? [CGColor]
        }
        set {
            gradientLayer?.colors = newValue
        }
    }

    var locations: [NSNumber]? {
        get {
            return gradientLayer?.locations
        }
        set {
            gradientLayer?.locations = newValue
        }
    }

    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     init() {
        super.init(frame: .zero)

        handleGradientDirectionUpdated()
    }
}

extension GradientView {
    private func handleGradientDirectionUpdated() {
        switch gradientDirection {
        case .leftToRight:
            gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topToBottom:
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1.0)
        }
    }
}
