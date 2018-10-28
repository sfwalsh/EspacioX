
import UIKit

final class LaunchListDefaultViewController: UIViewController, Navigatable {
    
    internal let presenter: LaunchListPresenter
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        return refreshControl
    }()
    
    init(withPresenter presenter: LaunchListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // No use of storyboards or xibs in the project, so this initializer is unavailable
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}


// MARK: LaunchListViewController Implementation

extension LaunchListDefaultViewController: LaunchListViewController {
    
    func performInitialSetup() {
        setupSubviews()
        setupConstraints()
    }
    
    func reloadView() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
}


// MARK: Layout, etc.

extension LaunchListDefaultViewController {
    
    private func setupSubviews() {
        setupTableView()
        setupRefreshControl()
        view.addSubviewsForAutolayout(views: [
            tableView
            ])
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        presenter.didPullToRefresh()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}


// MARK: UITableViewDatasource & UITableViewDelegate

extension LaunchListDefaultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems(inSection: section)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = presenter.item(atIndexPath: indexPath) else { return UITableViewCell() }
        switch item {
        case .countdown(let launch):
            break
        case .listItem(let launch):
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(atIndexPath: indexPath)
    }
}
