
import UIKit

final class LaunchDetailDefaultViewController: UIViewController {
    
    internal let presenter: LaunchDetailPresenter
    
    init(withPresenter presenter: LaunchDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: LaunchDetailViewController Implementation

extension LaunchDetailDefaultViewController: LaunchDetailViewController {
    
    func setTitle(title: String) {
        self.title = title
    }
    
    func performInitialSetup() {
        setupSubviews()
        setupConstraints()
    }
    
    func reloadView() {
        
    }
}


// MARK: Setup

extension LaunchDetailDefaultViewController {
    
    private func setupSubviews() {
        view.backgroundColor = Palette.iodineBlack
    }
    
    private func setupConstraints() {
        
    }
}
