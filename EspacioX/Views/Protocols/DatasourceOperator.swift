
import UIKit

protocol DatasourceOperator {
    associatedtype DatasourceType
    
    func numberOfSections() -> Int
    func numberOfItems(inSection section: Int) -> Int
    func item(atIndexPath indexPath: IndexPath) -> DatasourceType?
    func didSelectItem(atIndexPath indexPath: IndexPath)
    func sectionTitle(forSection section: Int) -> String?
}
