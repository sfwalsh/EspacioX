
import UIKit

protocol Navigatable: class {
    var navigationController: UINavigationController? { get }
    
    func present(_ viewControllerToPresent: UIViewController,
                 animated flag: Bool,
                 completion: (() -> Void)?)
}
