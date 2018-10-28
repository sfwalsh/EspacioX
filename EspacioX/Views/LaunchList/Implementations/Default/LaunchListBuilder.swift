
import UIKit


// This could have been a struct, but in order to make it uninstantiable its an enum

enum LaunchListBuilder {
    
    static func build() -> UIViewController {
        
        let interactor = LaunchListDefaultInteractor()
        let router = LaunchListDefaultRouter()
        
        let presenter = LaunchListDefaultPresenter(withInteractor: interactor,
                                                   router: router)
        let view = LaunchListDefaultViewController(withPresenter: presenter)
        presenter.attachView(view: view)
        
        return buildNavigationController(forViewController: view)
    }
    
    private static func buildNavigationController(forViewController viewController: UIViewController) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.barTintColor = Palette.midnightBlue
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barStyle = .blackOpaque
        
        return navigationController
    }
}
