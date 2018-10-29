
import Foundation

protocol LaunchListViewController: class {
    var presenter: LaunchListPresenter { get }
    
    func setTitle(title: String)
    func performInitialSetup()
    func reloadView()
    func showLoader()
    func hideLoader()
}
