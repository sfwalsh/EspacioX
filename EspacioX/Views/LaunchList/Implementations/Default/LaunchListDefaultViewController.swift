
import UIKit

final class LaunchListDefaultViewController: UIViewController, Navigatable {
    
    internal let presenter: LaunchListPresenter
    
    init(withPresenter presenter: LaunchListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // No use of storyboards or xibs in the project, so this initializer is unavailable
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
}


// MARK: LaunchListViewController Implementation

extension LaunchListDefaultViewController: LaunchListViewController {
    
    func reloadView() {
        
    }
    
    func showLoader() {
        
    }
    
    func hideLoader() {
        
    }
}
