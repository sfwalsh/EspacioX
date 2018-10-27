
import UIKit

protocol AlertPresentable {
    var view: Navigatable? {get set}
}

extension AlertPresentable {
    
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
        
        view?.navigationController?.present(alertViewController,
                                            animated: true,
                                            completion: nil)
    }
}
