//
//  Copyright © 2022 Future Mind. All rights reserved.
//

import UIKit

final class DashboardView: UIView {
    
    // MARK: - Properties
    
    let backgroundGradientView = GradientView()
    let sectionTitle = SectionTitleView()
    let counterLoop = CounterLoop()
    let bannerCode = BannerCodeView()
    let refreshControl = UIRefreshControl()
    private var rewardViews: [String: CardView] = [:]
    
    private let scrollView = UIScrollView()
    private let mainStackView = UIStackView()
    private let rewardsScrollView = UIScrollView()
    private let rewardsHorizontalStackView = UIStackView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
}

extension DashboardView {
    private func setupLayout() {
        constructHierarchy()
        
        prepareBackgroundGradientView()
        prepareScrollView()
        prepareMainStackView()
        prepareSectionTitle()
        prepareCounterLoop()
        prepareRewardsScrollView()
        prepareRewardsHorizontalStackView()
        prepareBannerCode()
    }
    
    private func constructHierarchy() {
        addSubview(backgroundGradientView)
        addSubview(scrollView)
        scrollView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(sectionTitle)
        mainStackView.addArrangedSubview(counterLoop)
        mainStackView.addArrangedSubview(rewardsScrollView)
        mainStackView.addArrangedSubview(bannerCode)
        
        rewardsScrollView.addSubview(rewardsHorizontalStackView)
    }
    
    private func prepareBackgroundGradientView() {
        backgroundGradientView.gradientDirection = .topToBottom
        backgroundGradientView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundGradientView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backgroundGradientView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func prepareScrollView() {
        scrollView.refreshControl = refreshControl
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func prepareMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = Margin.default
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Margin.medium),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mainStackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func prepareSectionTitle() {
        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func prepareCounterLoop() {
        counterLoop.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func prepareRewardsScrollView() {
        rewardsScrollView.showsHorizontalScrollIndicator = false
        rewardsScrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func prepareRewardsHorizontalStackView() {
        rewardsHorizontalStackView.axis = .horizontal
        rewardsHorizontalStackView.spacing = Margin.medium
        rewardsHorizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rewardsHorizontalStackView.leadingAnchor.constraint(equalTo: rewardsScrollView.leadingAnchor, constant: Margin.default),
            rewardsHorizontalStackView.trailingAnchor.constraint(equalTo: rewardsScrollView.trailingAnchor, constant: -Margin.default),
            rewardsHorizontalStackView.topAnchor.constraint(equalTo: rewardsScrollView.topAnchor),
            rewardsHorizontalStackView.bottomAnchor.constraint(equalTo: rewardsScrollView.bottomAnchor),
            rewardsHorizontalStackView.heightAnchor.constraint(equalTo: rewardsScrollView.heightAnchor)
        ])
    }
    
    private func prepareBannerCode() {
        counterLoop.translatesAutoresizingMaskIntoConstraints = false
        bannerCode.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func updateRewards(with viewModels: [RewardViewModel], onAction: @escaping (String) -> Void) {
        let existingViews = rewardsHorizontalStackView.arrangedSubviews.compactMap { $0 as? CardView }
        let newRewards = viewModels
        
        for view in existingViews {
            if !newRewards.contains(where: { $0.id == view.viewModel?.id }) {
                rewardsHorizontalStackView.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        
        for newViewModel in newRewards {
            if let existingView = existingViews.first(where: { $0.viewModel?.id == newViewModel.id }) {
                CardViewDecorator.decorate(existingView, with: newViewModel)
            } else {
                let cardView = CardView()
                CardViewDecorator.decorate(cardView, with: newViewModel)
                cardView.onTap = {
                    onAction(newViewModel.id)
                }
                rewardsHorizontalStackView.addArrangedSubview(cardView)
            }
        }
    }
}
