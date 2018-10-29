
import UIKit

enum LaunchDetailBuilder {
    
    static func build(withLaunch launch: Launch) -> UIViewController {
        let presenter = LaunchDetailDefaultPresenter(withLaunch: launch)
        let viewController = LaunchDetailDefaultViewController(withPresenter: presenter)
        
        presenter.attachView(view: viewController)
        
        return viewController
    }
}
