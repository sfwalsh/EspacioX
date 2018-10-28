
import Foundation

final class LaunchListDefaultPresenter {
    
    private let interactor: LaunchListInteractor
    private let router: LaunchListRouter
    private weak var view: LaunchListViewController?
    
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
                    self?.view?.reloadView()
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    private func handleError(error: Error) {
        // FIXME: Localize this
        router.presentAlert(withTitle: "Error",
                            message: error.localizedDescription,
                            options: [("OK", {})])
    }
}
