
import Foundation

@testable import EspacioX

final class MockLaunchListViewController: LaunchListViewController {
    
    struct DidCall {
        var performInitialSetup: Bool = false
        var reloadView: Bool = false
        var showLoader: Bool = false
        var hideLoader: Bool = false
    }
    
    struct DidUpdate {
        var title: String? = nil
        
        func title(to value: String?) -> Bool {
            return value == title
        }
    }
    
    var didCall: DidCall = DidCall()
    var didUpdate: DidUpdate = DidUpdate()
    
    var presenter: LaunchListPresenter
    
    init(withPresenter presenter: LaunchListPresenter) {
        self.presenter = presenter
    }
    
    func setTitle(title: String) {
        didUpdate.title = title
    }
    
    func performInitialSetup() {
        didCall.performInitialSetup = true
    }
    
    func reloadView() {
        didCall.reloadView = true
    }
    
    func showLoader() {
        didCall.showLoader = true
    }
    
    func hideLoader() {
        didCall.hideLoader = true
    }
}
