//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

extension UIView {
    func embedSubview(_ subview: UIView, edgeInsets: UIEdgeInsets = .zero) {
        guard subview.superview != self else {
            return
        }

        subview.removeFromSuperview()
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)

        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: edgeInsets.top),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInsets.bottom),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInsets.left),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInsets.right)
        ])
    }
}
