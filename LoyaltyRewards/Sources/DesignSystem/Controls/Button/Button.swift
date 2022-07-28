//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

class Button: UIControl {
    private let gradientView = GradientView()
    private let mainStackView = UIStackView()
    private let imageView = UIImageView()
    private let label = UILabel()

    private var textColors: [UIControl.State: UIColor] = [:]
    private var backgroundGradientColors: [UIControl.State: [CGColor]] = [:]

    override var isEnabled: Bool {
        didSet {
            updateAppearance()
        }
    }

    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }

    var text: String? {
        get {
            return label.text
        }
        set {
            label.attributedText = NSAttributedString(string: newValue, font: font)
        }
    }

    var font: Font {
        didSet {
            label.font = font.font
            label.attributedText = NSAttributedString(string: text, font: font)
        }
    }

    var icon: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.isHidden = newValue == nil
        }
    }

    init() {
        font = Font(font: label.font)

        super.init(frame: .zero)

        icon = nil
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(textColor: UIColor, for state: UIControl.State) {
        textColors[state] = textColor
        updateAppearance()
    }

    func set(textColors: [UIControl.State: UIColor]) {
        self.textColors = textColors
        updateAppearance()
    }

    func set(backgroundGradientColors: [CGColor], for state: UIControl.State) {
        self.backgroundGradientColors[state] = backgroundGradientColors
        updateAppearance()
    }

    func set(backgroundGradientColors: [UIControl.State: [CGColor]]) {
        self.backgroundGradientColors = backgroundGradientColors
        updateAppearance()
    }
}

extension Button {
    private func setupView() {
        constructHierarchy()

        prepareGradientView()
        prepareMainStackView()
        prepareImageView()
        prepareLabel()

        makeRootViewTappable()
    }

    private func constructHierarchy() {
        embedSubview(gradientView)

        addSubview(mainStackView)

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(label)
    }

    private func prepareGradientView() {
        gradientView.gradientDirection = .rightToLeft
        gradientView.layer.cornerRadius = Margin.default
        gradientView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.spacing = Margin.tiny
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: Margin.extraSmall),
            mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: Margin.extraSmall),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.extraSmall),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Margin.extraSmall),
            mainStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    private func prepareImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareLabel() {
        label.numberOfLines = 2
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func makeRootViewTappable() {
        subviews.forEach {
            $0.isUserInteractionEnabled = false
        }
        isUserInteractionEnabled = true

        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
    }

    private func updateAppearance() {
        label.textColor = textColors[state] ?? textColors[.normal]
        gradientView.colors = backgroundGradientColors[state] ?? backgroundGradientColors[.normal]
    }

    @objc private func handleTouchUpInside() {
        isHighlighted = true
        updateAppearance()
    }
}
