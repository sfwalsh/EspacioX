
import Foundation

protocol LaunchListRouter: Router {
    func routeToDetail(withId id: Int)
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [(String, (() -> Void))])
}
