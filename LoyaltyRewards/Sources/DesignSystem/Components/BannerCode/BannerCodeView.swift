//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class BannerCodeView: UIView {
    private enum Constants {
        static let buttonSize = CGSize(width: 240, height: 40)
    }

    private let mainStackView = UIStackView()

    private let gradientView = GradientView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    let shareButton = Button()

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.attributedText = NSAttributedString(string: newValue, font: titleFont)
        }
    }

    var message: String? {
        get {
            return messageLabel.text
        }
        set {
            messageLabel.attributedText = NSAttributedString(string: newValue, font: messageFont)
        }
    }

    var titleFont: Font {
        didSet {
            titleLabel.font = titleFont.font
            titleLabel.attributedText = NSAttributedString(string: title, font: titleFont)
        }
    }

    var messageFont: Font {
        didSet {
            messageLabel.font = messageFont.font
            messageLabel.attributedText = NSAttributedString(string: message, font: messageFont)
        }
    }

    var titleColor: UIColor? {
        get {
            return titleLabel.textColor
        }
        set {
            titleLabel.textColor = newValue
        }
    }
    var messageColor: UIColor? {
        get {
            return messageLabel.textColor
        }
        set {
            messageLabel.textColor = newValue
        }
    }

    var gradientColors: [CGColor]? {
        get {
            return gradientView.colors
        }
        set {
            gradientView.colors = newValue
        }
    }

    var gradientLocations: [Float]? {
        get {
            return gradientView.locations?.map { $0.floatValue }
        }
        set {
            gradientView.locations = newValue?.map { NSNumber(value: $0) }
        }
    }

    init() {
        titleFont = Font(font: titleLabel.font)
        messageFont = Font(font: messageLabel.font)

        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerCodeView {
    private func setupView() {
        constructHierarchy()

        prepareGradientView()
        prepareMainStackView()
        prepareTitleLabel()
        prepareMessageLabel()
        prepareShareButton()
    }

    private func constructHierarchy() {
        let insets = UIEdgeInsets(
            top: 0,
            left: Margin.default,
            bottom: 0,
            right: -Margin.default
        )

        embedSubview(gradientView, edgeInsets: insets)

        gradientView.addSubview(mainStackView)

        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(messageLabel)
        mainStackView.addArrangedSubview(shareButton)
    }

    private func prepareGradientView() {
        gradientView.gradientDirection = .rightToLeft
        gradientView.layer.cornerRadius = Margin.default
        gradientView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = Margin.default
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: Margin.medium),
            mainStackView.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -Margin.medium),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.medium),
            mainStackView.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: Margin.medium)
        ])
    }

    private func prepareTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareShareButton() {
        shareButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shareButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize.width),
            shareButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize.height)
        ])
    }
}
