
import Foundation

protocol LaunchListRouter: Router {
    func routeToDetail(withLaunch launch: Launch)
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [(String, (() -> Void))])
}
