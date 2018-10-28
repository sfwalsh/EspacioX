
import UIKit

final class LaunchListDefaultViewController: UIViewController, Navigatable {
    
    internal let presenter: LaunchListPresenter
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
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
        view.addSubviewsForAutolayout(views: [
            tableView
            ])
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
