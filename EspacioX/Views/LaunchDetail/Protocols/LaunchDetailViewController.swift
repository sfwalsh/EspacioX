
import Foundation

protocol LaunchDetailViewController: class {
    var presenter: LaunchDetailPresenter { get }
    
    func setTitle(title: String)
    func performInitialSetup()
    func reloadView()
}
