
import Foundation

final class LaunchListDefaultPresenter {
    
    private let interactor: LaunchListInteractor
    private let router: LaunchListRouter
    private weak var view: LaunchListViewController?
    
    private var upcomingLaunches: [Launch] = []
    private var nextLaunch: Launch?
    
    init(withInteractor interactor: LaunchListInteractor,
         router: LaunchListRouter) {
        self.interactor = interactor
        self.router = router
    }
}


// MARK: LaunchListPresenter Implementation

extension LaunchListDefaultPresenter: LaunchListPresenter {
    
    func attachView(view: LaunchListViewController & Navigatable) {
        self.view = view
        router.attachView(view: view)
    }
    
    func viewDidLoad() {
        view?.performInitialSetup()
        view?.setTitle(title: "EspacioX")
        fetchUpcomingLaunches()
        fetchNextLaunch()
    }
    
    func didPullToRefresh() {
        fetchUpcomingLaunches()
        fetchNextLaunch()
    }
}


// MARK: Private functions

extension LaunchListDefaultPresenter {
    
    private func fetchNextLaunch() {
        view?.showLoader()
        interactor.fetchNextLaunch { [weak self] (result) in
            DispatchQueue.main.async {
                self?.view?.hideLoader()
                switch result {
                case .success(let launch):
                    self?.nextLaunch = launch
                    self?.view?.reloadView()
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    private func fetchUpcomingLaunches() {
        view?.showLoader()
        interactor.fetchUpcomingLaunches { [weak self] (result) in
            DispatchQueue.main.async {
                self?.view?.hideLoader()
                switch result {
                case .success(let launches):
                    self?.upcomingLaunches = launches
                    self?.view?.reloadView()
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    private func handleError(error: Error) {
        router.presentAlert(withTitle: NSLocalizedString("ERROR", comment: ""),
                            message: error.localizedDescription,
                            options: [(NSLocalizedString("OK", comment: ""), {})])
    }
}


// MARK: Datasource Operator Conformance

extension LaunchListDefaultPresenter {
    
    private enum Section: Int {
        case nextLaunch = 0
        case upcomingLaunches = 1
    }

    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .nextLaunch:
            if let _ = nextLaunch {
                return 1
            }
            return 0
        case .upcomingLaunches:
            return upcomingLaunches.count
        }
    }
    
    func item(atIndexPath indexPath: IndexPath) -> LaunchListItem? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        switch section {
        case .nextLaunch:
            guard let nextLaunch = nextLaunch else { return nil }
            let launchViewModel = LaunchViewModel(withLaunch: nextLaunch)
            return LaunchListItem.countdown(launch: launchViewModel)
        case .upcomingLaunches:
            guard let launch = upcomingLaunches[safe: indexPath.row] else { return nil }
            let launchViewModel = LaunchViewModel(withLaunch: launch)
            return LaunchListItem.listItem(launch: launchViewModel)
        }
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        guard let item = item(atIndexPath: indexPath) else { return }
        // MARK: Implement this
    }
    
    func shouldShowHeader(forSection section: Int) -> Bool {
        guard let section = Section(rawValue: section) else { return false }
        
        switch section {
        case .upcomingLaunches:
            return upcomingLaunches.count > 0
        case .nextLaunch:
            return false
        }
    }
}
