//
// Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit
import Combine
import RewardsAPI

final class CardView: UIView {
    private enum Constants {
        static let buttonWidth: CGFloat = 120
        static let imageViewHeight: CGFloat = 170
    }

    private let mainStackView = UIStackView()
    private let imageView = UIImageView()
    private let imageOverlayView = UIView()
    private let titleLabel = UILabel()
    private var cancellables = Set<AnyCancellable>()
    
    let button = Button()

    var buttonTitle: String? {
        didSet {
            button.text = buttonTitle
        }
    }
    
    var viewModel: RewardViewModel?
    
    var onTap: (() -> Void)? // Nowy closure do obsługi kliknięć

    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }

    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.attributedText = NSAttributedString(string: newValue, font: titleFont)
        }
    }

    var titleFont: Font {
        didSet {
            titleLabel.font = titleFont.font
            titleLabel.attributedText = NSAttributedString(string: title, font: titleFont)
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

    var imageOverlayColor: UIColor? {
        didSet {
            imageOverlayView.backgroundColor = imageOverlayColor
        }
    }

    init() {
        titleFont = Font(font: titleLabel.font)

        super.init(frame: .zero)

        imageOverlayColor = .clear
        setupView()
        
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func handleTap() {
        onTap?()
    }
    
    func loadImage(from url: URL?) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()

        guard let url = url else {
            imageView.image = nil
            return
        }

        API.shared.loadImage(for: url)
            .replaceError(with: UIImage())
            .map { $0 }
            .assign(to: \.image, on: imageView)
            .store(in: &cancellables)
    }
}

extension CardView {
    private func setupView() {
        constructHierarchy()
        
        prepareRootView()
        prepareMainStackView()
        prepareImageView()
        prepareImageOverlayView()
        prepareTitleLabel()
        prepareButton()
    }

    private func constructHierarchy() {
        let insets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: -Margin.medium,
            right: 0
        )
        embedSubview(mainStackView, edgeInsets: insets)

        imageView.addSubview(imageOverlayView)

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(button)
    }

    private func prepareRootView() {
        clipsToBounds = true
        layer.cornerRadius = Margin.extraSmall
    }

    private func prepareMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func prepareImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageViewHeight)
        ])
    }

    private func prepareImageOverlayView() {
        imageOverlayView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageOverlayView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageOverlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageOverlayView.topAnchor.constraint(equalTo: imageView.topAnchor),
            imageOverlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }

    private func prepareTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: Margin.default),
            titleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -Margin.default),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Margin.default),
            titleLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -Margin.default)
        ])
    }

    private func prepareButton() {
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: Constants.buttonWidth)
        ])
    }
    
}
