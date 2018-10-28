
import Foundation

protocol LaunchDetailPresenter: class {
    var viewModel: LaunchViewModel { get }
    
    func attachView(view: LaunchDetailViewController)
    func viewDidLoad()
}
