
import UIKit

final class LaunchListDefaultRouter: LaunchListRouter {
    
    weak var view: Navigatable?
    
    func routeToDetail(withLaunch launch: Launch) {
        let detailView = LaunchDetailBuilder.build(withLaunch: launch)
        
        guard let navigationController = view?.navigationController else {
            view?.present(detailView, animated: true, completion: nil)
            return
        }
        
        navigationController.pushViewController(detailView,
                                                animated: true)
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
