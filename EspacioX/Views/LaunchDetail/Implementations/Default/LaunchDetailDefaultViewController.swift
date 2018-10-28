
import UIKit

final class LaunchDetailDefaultViewController: UIViewController {
    
    private enum Layout {
        static let countdownHeight: CGFloat = 200.0
    }
    
    internal let presenter: LaunchDetailPresenter
    
    private let countdownView: LaunchCountdownView = {
       let countdownView = LaunchCountdownView(withTitle: NSLocalizedString("COUNTDOWN_ARBITRARY_LAUNCH",
                                                                            comment: ""))
        return countdownView
    }()
    
    init(withPresenter presenter: LaunchDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    deinit {
        countdownView.resetTimer()
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
        countdownView.setup(withViewModel: presenter.viewModel)
    }
}


// MARK: Setup

extension LaunchDetailDefaultViewController {
    
    private func setupSubviews() {
        view.backgroundColor = Palette.iodineBlack
        
        view.addSubviewForAutolayout(view: countdownView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countdownView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            countdownView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countdownView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countdownView.heightAnchor.constraint(equalToConstant: Layout.countdownHeight)
            ])
    }
}
