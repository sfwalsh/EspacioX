
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
}
