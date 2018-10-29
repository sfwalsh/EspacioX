
import Foundation

@testable import EspacioX

final class MockLaunchListPresenter: LaunchListPresenter {
    
    
    struct DidCall {
        var attachView: Bool = false
        var viewDidLoad: Bool = false
        var didPullToRefresh: Bool = false
        var numberOfSections: Bool = false
        var numberOfItems: Bool = false
        var itemAtIndexPath: Bool = false
        var didSelectItem: Bool = false
        var shouldShowHeader: Bool = false
    }
    
    var didCall: DidCall = DidCall()
    
    private let launchListItems: [LaunchListItem]
    
    init(withLaunchListItems launchListItems: [LaunchListItem]) {
        self.launchListItems = launchListItems
    }
    
    init(withItems launchListItems: [LaunchListItem]) {
        self.launchListItems = launchListItems
    }
    
    func attachView(view: LaunchListViewController & Navigatable) {
        didCall.attachView = true
    }
    
    func viewDidLoad() {
        didCall.viewDidLoad = true
    }
    
    func didPullToRefresh() {
        didCall.didPullToRefresh = true
    }
    
    func numberOfSections() -> Int {
        didCall.numberOfSections = true
        return 1
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        didCall.numberOfItems = true
        return launchListItems.count
    }
    
    func item(atIndexPath indexPath: IndexPath) -> LaunchListItem? {
        didCall.itemAtIndexPath = true
        return launchListItems[safe: indexPath.row]
    }
    
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        didCall.didSelectItem = true
    }
    
    func shouldShowHeader(forSection section: Int) -> Bool {
        didCall.shouldShowHeader = true
        return false
    }
}
