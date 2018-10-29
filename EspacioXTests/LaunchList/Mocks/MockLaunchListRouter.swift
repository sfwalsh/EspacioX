
import Foundation
@testable import EspacioX

final class MockLaunchListRouter: LaunchListRouter {
    
    struct DidCall {
        var routeToDetail: Bool = false
        var presentAlert: Bool = false
    }
    
    struct DidUpdate {
        var errorAlertMessage: String? = nil
        
        func errorAlertMessage(to value: String?) -> Bool {
            return value == errorAlertMessage
        }
    }
    
    var didCall: DidCall = DidCall()
    var didUpdate: DidUpdate = DidUpdate()
    
    var view: Navigatable?
    
    func routeToDetail(withLaunch launch: Launch) {
        didCall.routeToDetail = true
    }
    
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [(String, (() -> Void))]) {
        didCall.presentAlert = true
        didUpdate.errorAlertMessage = message
    }
}
