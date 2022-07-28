//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class SectionTitleView: UIView {
    private enum Constants {
        static let imageSize: CGFloat = 40
    }

    private let mainStackView = UIStackView()
    private let labelsStackView = UIStackView()

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let imageView = UIImageView()

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.attributedText = NSAttributedString(string: newValue, font: titleFont)
        }
    }

    var subtitle: String? {
        get {
            return subtitleLabel.text
        }
        set {
            subtitleLabel.attributedText = NSAttributedString(string: newValue, font: subtitleFont)
        }
    }

    var icon: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    var titleFont: Font {
        didSet {
            titleLabel.font = titleFont.font
            titleLabel.attributedText = NSAttributedString(string: title, font: titleFont)
        }
    }

    var subtitleFont: Font {
        didSet {
            subtitleLabel.font = subtitleFont.font
            subtitleLabel.attributedText = NSAttributedString(string: subtitle, font: subtitleFont)
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

    var subtitleColor: UIColor? {
        get {
            return subtitleLabel.textColor
        }
        set {
            subtitleLabel.textColor = newValue
        }
    }

    init() {
        titleFont = Font(font: titleLabel.font)
        subtitleFont = Font(font: subtitleLabel.font)

        super.init(frame: .zero)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SectionTitleView {
    private func setupView() {
        constructHierarchy()

        prepareMainStackView()
        prepareLabelsStackView()
        prepareTitleLabel()
        prepareSubtitleLabel()
        prepareImageView()
    }

    private func constructHierarchy() {
        let insets = UIEdgeInsets(
            top: 0,
            left: Margin.default,
            bottom: 0,
            right: -Margin.default
        )

        embedSubview(mainStackView, edgeInsets: insets)

        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(imageView)

        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
    }

    private func prepareMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .top
        mainStackView.distribution = .fill
    }

    private func prepareLabelsStackView() {
        labelsStackView.axis = .vertical
        labelsStackView.spacing = Margin.extraTiny
    }

    private func prepareTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareSubtitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageSize)
        ])
    }
}
