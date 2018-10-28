
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
        interactor.fetchUpcomingLaunches { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let launches):
                    break
                case .failure(let error):
                    self?.handleError(error: error)
                }
            }
        }
    }
}


// MARK: Private functions

extension LaunchListDefaultPresenter {
    
    private func handleError(error: Error) {
        // FIXME: Localize this
        router.presentAlert(withTitle: "Error",
                            message: error.localizedDescription,
                            options: [("OK", {})])
    }
}
