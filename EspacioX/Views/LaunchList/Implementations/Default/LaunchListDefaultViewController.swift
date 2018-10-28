
import UIKit

final class LaunchListDefaultViewController: UIViewController, Navigatable {
    
    private enum Layout {
        static let countdownHeight: CGFloat = 180
        static let launchInfoHeight: CGFloat = 70.0
        static let headerHeight: CGFloat = 50.0
    }
    
    internal let presenter: LaunchListPresenter
    
    private let backgroundGradientView: GradientView = {
        let view = GradientView(frame: .zero,
                                topColor: Palette.midnightBlue,
                                bottomColor: Palette.iodineBlack)
        return view
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        tableView.separatorInset = .zero
        tableView.separatorColor = Palette.iodineBlack
        tableView.register(LaunchCountdownCell.self,
                           forCellReuseIdentifier: LaunchCountdownCell.reuseIdentifier)
        tableView.register(LaunchInfoCell.self,
                           forCellReuseIdentifier: LaunchInfoCell.reuseIdentifier)
        tableView.register(LaunchListSectionHeaderCell.self,
                           forHeaderFooterViewReuseIdentifier: LaunchListSectionHeaderCell.reuseIdentifier)
        
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


// MARK: LaunchListViewController Implementation

extension LaunchListDefaultViewController: LaunchListViewController {
    
    func performInitialSetup() {
        setupSubviews()
        setupConstraints()
    }
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func reloadView() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showLoader() {
        // FIXME: Impl
    }
    
    func hideLoader() {
        // FIXME: Impl
    }
}


// MARK: Layout, etc.

extension LaunchListDefaultViewController {
    
    private func setupSubviews() {
        view.backgroundColor = Palette.midnightBlue
        setupTableView()
        setupRefreshControl()
        view.addSubviewsForAutolayout(views: [
            backgroundGradientView,
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
            
            backgroundGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundGradientView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundGradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
        case .countdown(let launchViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCountdownCell.reuseIdentifier,
                                                           for: indexPath) as? LaunchCountdownCell else {
                                                            return UITableViewCell()
            }
            cell.setup(withViewModel: launchViewModel)
            return cell
        case .listItem(let launchViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchInfoCell.reuseIdentifier,
                                                           for: indexPath) as? LaunchInfoCell else {
                                                            return UITableViewCell()
            }
            cell.setup(withViewModel: launchViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = presenter.item(atIndexPath: indexPath) else { return 0 }
        
        switch item {
        case .countdown:
            return Layout.countdownHeight
        case .listItem:
            return Layout.launchInfoHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        guard presenter.shouldShowHeader(forSection: section) else { return 0 }
        return Layout.headerHeight
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard presenter.shouldShowHeader(forSection: section) else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: LaunchListSectionHeaderCell.reuseIdentifier)
        return view
    }
}
