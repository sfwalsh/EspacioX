
import Foundation

protocol LaunchListViewController: class {
    var presenter: LaunchListPresenter { get }
    
    func performInitialSetup()
    func reloadView()
    func showLoader()
    func hideLoader()
}
