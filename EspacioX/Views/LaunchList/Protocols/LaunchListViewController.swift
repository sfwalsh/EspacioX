
import Foundation

protocol LaunchListViewController: class {
    var presenter: LaunchListPresenter { get }
    
    func reloadView()
    func showLoader()
    func hideLoader()
}
