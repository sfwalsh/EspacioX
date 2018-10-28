
import Foundation

protocol LaunchListPresenter: class {
    func attachView(view: LaunchListViewController & Navigatable)
    func viewDidLoad()
    func didPullToRefresh()
    
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    func item(atIndexPath indexPath: IndexPath) -> LaunchListItem?
    func didSelectItem(atIndexPath indexPath: IndexPath)
    func shouldShowHeader(forSection section: Int) -> Bool
}
