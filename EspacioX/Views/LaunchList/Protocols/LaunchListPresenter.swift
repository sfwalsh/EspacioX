
import Foundation

protocol LaunchListPresenter: class {
    
    func attachView(view: LaunchListViewController & Navigatable)
    
}
