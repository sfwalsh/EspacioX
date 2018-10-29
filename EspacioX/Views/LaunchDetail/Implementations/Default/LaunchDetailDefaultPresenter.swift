
import Foundation

// This is only a dummy / stub detail view to demonstrate the pattern.
// In a full app this would have the same components as the LaunchList module

final class LaunchDetailDefaultPresenter: LaunchDetailPresenter {

    private weak var view: LaunchDetailViewController?
    
    private let launch: Launch
    
    var viewModel: LaunchViewModel {
        return LaunchViewModel(withLaunch: launch)
    }
    
    init(withLaunch launch: Launch) {
        self.launch = launch
    }
}


// MARK: LaunchDetailPresenter Implementation

extension LaunchDetailDefaultPresenter {
    
    func attachView(view: LaunchDetailViewController) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.performInitialSetup()
        view?.setTitle(title: viewModel.missionName)
        view?.reloadView()
    }
}
