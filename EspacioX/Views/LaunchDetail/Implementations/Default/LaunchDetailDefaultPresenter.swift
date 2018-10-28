
import Foundation

final class LaunchDetailDefaultPresenter: LaunchDetailPresenter {

    private weak var view: LaunchDetailViewController?
    
    private let launch: Launch
    
    private var viewModel: LaunchViewModel {
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
    }
}
