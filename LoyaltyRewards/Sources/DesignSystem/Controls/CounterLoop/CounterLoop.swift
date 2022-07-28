//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

class CounterLoop: UIControl {
    private enum Constants {
        static let iconSize: CGFloat = 72
    }

    private let mainStackView = UIStackView()
    private let verticalStackView = UIStackView()
    private let topHorizontalStackView = UIStackView()

    private let imageView = UIImageView()
    private let pointsLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView()

    private var pointsColors: [UIControl.State: UIColor] = [:]
    private var pointsSuffixColors: [UIControl.State: UIColor] = [:]
    private var subtitleColors: [UIControl.State: UIColor] = [:]
    private var loaderColors: [UIControl.State: UIColor] = [:]

    var points: String? {
        didSet {
            updatePointsText()
        }
    }

    var pointsSuffix: String? {
        didSet {
            updatePointsText()
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

    var loading: Bool {
        get {
            return activityIndicator.isAnimating
        }
        set {
            if newValue {
                if !activityIndicator.isAnimating {
                    activityIndicator.startAnimating()
                }
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

    var pointsFont: Font {
        didSet {
            pointsLabel.font = pointsFont.font
            updatePointsText()
        }
    }

    var subtitleFont: Font {
        didSet {
            subtitleLabel.font = subtitleFont.font
            subtitleLabel.attributedText = NSAttributedString(string: subtitle, font: subtitleFont)
        }
    }

    init() {
        pointsFont = Font(font: pointsLabel.font)
        subtitleFont = Font(font: subtitleLabel.font)

        super.init(frame: .zero)

        loading = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(pointsColor: UIColor, for state: UIControl.State) {
        pointsColors[state] = pointsColor
        updateAppearance()
    }

    func set(pointsColors: [UIControl.State: UIColor]) {
        self.pointsColors = pointsColors
        updateAppearance()
    }

    func set(pointsSuffixColor: UIColor, for state: UIControl.State) {
        pointsSuffixColors[state] = pointsSuffixColor
        updateAppearance()
    }

    func set(pointsSuffixColors: [UIControl.State: UIColor]) {
        self.pointsSuffixColors = pointsSuffixColors
        updateAppearance()
    }

    func set(subtitleColor: UIColor, for state: UIControl.State) {
        subtitleColors[state] = subtitleColor
        updateAppearance()
    }

    func set(subtitleColors: [UIControl.State: UIColor]) {
        self.subtitleColors = subtitleColors
        updateAppearance()
    }

    func set(loaderColor: UIColor, for state: UIControl.State) {
        loaderColors[state] = loaderColor
        updateAppearance()
    }

    func set(loaderColors: [UIControl.State: UIColor]) {
        self.loaderColors = loaderColors
        updateAppearance()
    }
}

extension CounterLoop {
    private func setupView() {
        constructHierarchy()

        prepareMainStackView()
        prepareImageView()
        prepareTopHorizontalStackView()
        prepareVerticalStackView()
        preparePointsLabel()
        prepareActivityIndicator()
        prepareSubtitleLabel()
    }

    private func constructHierarchy() {
        let insets = UIEdgeInsets(
            top: 0,
            left: Margin.default,
            bottom: 0,
            right: -Margin.default
        )

        embedSubview(mainStackView, edgeInsets: insets)

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(verticalStackView)

        topHorizontalStackView.addArrangedSubview(pointsLabel)
        topHorizontalStackView.addArrangedSubview(activityIndicator)

        verticalStackView.addArrangedSubview(topHorizontalStackView)
        verticalStackView.addArrangedSubview(subtitleLabel)
    }

    private func prepareMainStackView() {
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = Margin.default
    }

    private func prepareImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.iconSize)
        ])
    }

    private func prepareTopHorizontalStackView() {
        topHorizontalStackView.axis = .horizontal
        topHorizontalStackView.alignment = .center
        topHorizontalStackView.spacing = Margin.medium
        topHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareVerticalStackView() {
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.spacing = Margin.extraTiny

        pointsLabel.translatesAutoresizingMaskIntoConstraints = false

        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func preparePointsLabel() {
        pointsLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareSubtitleLabel() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    private func updateAppearance() {
        updatePointsText()

        subtitleLabel.textColor = subtitleColors[state] ?? subtitleColors[.normal]
        activityIndicator.color = loaderColors[state] ?? loaderColors[.normal]
    }

    private func updatePointsText() {
        let attributedText = NSMutableAttributedString(string: "")

        if let points = points {
            let color =  pointsColors[state] ?? pointsColors[.normal]
            let pointsValueText = NSAttributedString(string: points)
                .adding(font: pointsFont)
                .adding(color: color ?? .black)

            attributedText.append(pointsValueText)
        }

        let suffixColor =  pointsSuffixColors[state] ?? pointsSuffixColors[.normal]
        let suffixText = " \(pointsSuffix ?? "")"
        let suffixAttributedText = NSMutableAttributedString(string: suffixText)
            .adding(font: pointsFont)
            .adding(color: suffixColor ?? .black)

        attributedText.append(suffixAttributedText)

        pointsLabel.attributedText = attributedText
    }
}
