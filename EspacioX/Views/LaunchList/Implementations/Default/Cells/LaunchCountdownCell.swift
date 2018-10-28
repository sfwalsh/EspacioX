
import UIKit

final class LaunchCountdownCell: UITableViewCell, ReusableCell {
    
    // FIXME: Strings
    
    private enum Layout {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.body
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Next Launch"
        
        return label
    }()
    
    private let rocketLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.boldBody
        label.textColor = Palette.luminousGreen
        label.textAlignment = .right
        
        return label
    }()
    
    private let countdownLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.extraLargeFont
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let launchDateLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.boldAnnotation
        label.textColor = Palette.awfullyOrange
        label.textAlignment = .left
        
        return label
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        return stackView
    }()
    
    private let launchDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM d, yyyy, HH:mm"

        return dateFormatter
    }()
    
    private var viewModel: LaunchViewModel?
    private var timer: Timer?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: Public actions
    
    func setup(withViewModel viewModel: LaunchViewModel) {
        
        rocketLabel.textColor = viewModel.reusedStatusColor
        rocketLabel.text = viewModel.formattedRocketName + " 🚀"
        setupCountdownTimer(forViewModel: viewModel)
        setupLaunchDateLabel(forViewModel: viewModel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetTimer()
    }
    
    deinit {
        resetTimer()
    }
}


// MARK: Data population

extension LaunchCountdownCell {
    
    private func createDateFormatter(withFormat format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = NSLocale.current
        formatter.dateFormat = format
        return formatter
    }
    
    private func updateCountdownLabel() {
        guard let viewModel = viewModel else { return }
        let dayHourMinuteString = viewModel.createCountdownString(forDateFormatter: createDateFormatter(withFormat: "d'd' H'h' m'm'"))
        let secondsString = viewModel.createCountdownString(forDateFormatter: createDateFormatter(withFormat: "s's'"))
        let combinedString = dayHourMinuteString + " " + secondsString
        countdownLabel.attributedText = combinedString.biFontString(forPrimaryFont: FontMachine.extraLargeFont,
                                                                    highlightedFont: FontMachine.largeFont,
                                                                    textColor: .white,
                                                                    highlightedText: secondsString)
    }
    
    private func setupLaunchDateLabel(forViewModel viewModel: LaunchViewModel) {
        launchDateLabel.text = viewModel.createMissionTimeString(forDateFormatter: launchDateFormatter)
    }
}


// MARK: Timer Related

extension LaunchCountdownCell {
    
    private func setupCountdownTimer(forViewModel viewModel: LaunchViewModel) {
        resetTimer()
        self.viewModel = viewModel
        updateCountdownLabel()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            self?.updateCountdownLabel()
        })
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = nil
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
        titleStackView.addArrangedSubviews(views: [
            titleLabel,
            rocketLabel
            ])
        
        rootStackView.addArrangedSubviews(views: [
            titleStackView,
            countdownLabel,
            launchDateLabel
            ])
        
        addSubviewForAutolayout(view: rootStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.insets.left),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.insets.right),
            rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.insets.top),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.insets.bottom)
            ])
    }
}
