
import UIKit

final class LaunchListDefaultRouter: LaunchListRouter {
    
    weak var view: Navigatable?
    
    func routeToDetail(withId id: Int) {
        
    }
    
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [(String, (() -> Void))]) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        options.forEach({ option in
            let action = UIAlertAction(title: option.0,
                                       style: .default,
                                       handler: { _ in
                                        option.1()
            })
            alertViewController.addAction(action)
        })
        
        view?.present(alertViewController,
                      animated: true,
                      completion: nil)
    }
}
