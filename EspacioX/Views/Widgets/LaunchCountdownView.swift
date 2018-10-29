
import UIKit

final class LaunchCountdownView: UIView {
    
    private enum Layout {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 24, left: 12, bottom: 24, right: 12)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.body
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    private let rocketLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.boldBody
        label.textColor = Palette.luminousGreen
        label.textAlignment = .right
        label.numberOfLines = 0
        
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
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        setupUI(withTitle: title)
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: Public actions
    
    func setup(withViewModel viewModel: LaunchViewModel) {
        
        rocketLabel.textColor = viewModel.reusedStatusColor
        rocketLabel.text = viewModel.formattedRocketName + " 🚀"
        setupCountdownTimer(forViewModel: viewModel)
        setupLaunchDateLabel(forViewModel: viewModel)
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        resetTimer()
    }
}


// MARK: Data population

extension LaunchCountdownView {
    
    private func createDateComponentsFormatter(withUnits units: NSCalendar.Unit) -> DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = units
        formatter.unitsStyle = .abbreviated
        
        return formatter
    }
    
    private func createSecondsString(forComponents components: DateComponents) -> String {
        guard let secondsValue = components.second else { return "" }
        return "\(secondsValue)s"
    }
    
    private func createDaysHoursMinutesString(forComponents components: DateComponents) -> String {
        let formatter = createDateComponentsFormatter(withUnits: [.day, .hour, .minute])
        guard let dayHourMinuteString = formatter.string(from: components) else {
            return ""
        }
        
        return dayHourMinuteString
    }
    
    private func updateCountdownLabel() {
        guard let viewModel = viewModel else { return }
        let components = viewModel.createDateCountdownComponentsInterval()
        let dayHourMinuteString = createDaysHoursMinutesString(forComponents: components)
        let secondsString = createSecondsString(forComponents: components)
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

extension LaunchCountdownView {
    
    private func setupCountdownTimer(forViewModel viewModel: LaunchViewModel) {
        resetTimer()
        self.viewModel = viewModel
        updateCountdownLabel()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            self?.updateCountdownLabel()
        })
    }
}


// MARK: Setup

extension LaunchCountdownView {
    
    private func setupUI(withTitle title: String) {
        titleLabel.text = title
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
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
