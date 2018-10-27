
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
        
        return view
    }
}
