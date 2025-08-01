//
//  Copyright © 2022 Future Mind. All rights reserved.
//

import Combine
import UIKit

final class DashboardViewController: UIViewController {
    private let dashboardView: DashboardView
    private let viewModel: DashboardViewModelProtocol
    private let dashboardFactory: DashboardProducing
    
    private var cancellables: Set<AnyCancellable> = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(view: DashboardView, viewModel: DashboardViewModelProtocol, dashboardFactory: DashboardProducing) {
        self.dashboardView = view
        self.viewModel = viewModel
        self.dashboardFactory = dashboardFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = dashboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBindings()
        dashboardView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.viewModel.fetchData()
    }
    
    @objc private func refreshData() {
        viewModel.fetchData()
    }
}

extension DashboardViewController {
    private func setupNavigationBar() {
        navigationItem.title = Localized.dashboardTitle
    }
    
    private func setupBindings() {
        viewModel.customerName
            .receive(on: DispatchQueue.main)
            .map { Localized.dashboardWelcomeTitle($0) }
            .assign(to: \.title, on: dashboardView.sectionTitle)
            .store(in: &cancellables)
        
        viewModel.points
            .receive(on: DispatchQueue.main)
            .map { "\($0)" }
            .assign(to: \.points, on: dashboardView.counterLoop)
            .store(in: &cancellables)
        
        viewModel.rewards
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewModels in
                self?.dashboardView.updateRewards(with: viewModels, onAction: { rewardId in
                    self?.viewModel.handleRewardAction(for: rewardId)
                })
            }
            .store(in: &cancellables)
        
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.dashboardView.refreshControl.beginRefreshing()
                } else {
                    self?.dashboardView.refreshControl.endRefreshing()
                }
            }
            .store(in: &cancellables)
        
        viewModel.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard let errorVC = self?.dashboardFactory.makeErrorViewController(error: error) else { return }
                self?.present(errorVC, animated: true, completion: nil)
            }
            .store(in: &cancellables)
    }
}
