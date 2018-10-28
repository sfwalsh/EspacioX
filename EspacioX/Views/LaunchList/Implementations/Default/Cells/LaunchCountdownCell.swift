
import UIKit

final class LaunchCountdownCell: UITableViewCell, ReusableCell {
    
    private let countdownView: LaunchCountdownView = {
        let view = LaunchCountdownView(withTitle: NSLocalizedString("COUNTDOWN_NEXT_LAUNCH", comment: ""))
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: Public actions
    
    func setup(withViewModel viewModel: LaunchViewModel) {
        countdownView.setup(withViewModel: viewModel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        countdownView.resetTimer()
    }
}


// MARK: Setup

extension LaunchCountdownCell {
    
    private func setupUI() {
        backgroundColor = .clear
        setupSelectedBackgroundView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSelectedBackgroundView() {
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = Palette.lighterShadeOfWhite
        self.selectedBackgroundView = selectedBackgroundView
    }

    private func setupSubviews() {
        addSubviewForAutolayout(view: countdownView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countdownView.leadingAnchor.constraint(equalTo: leadingAnchor),
            countdownView.trailingAnchor.constraint(equalTo: trailingAnchor),
            countdownView.topAnchor.constraint(equalTo: topAnchor),
            countdownView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
