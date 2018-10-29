
import UIKit

final class LaunchInfoCell: UITableViewCell, ReusableCell {
    
    private enum Layout {
        static let dateWidthMultiplier: CGFloat = 0.18
        static let missionRocketWidthMultiplier: CGFloat = 0.26
        static let interitemSpacing: CGFloat = 8
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
    }
 
    private let launchDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontMachine.boldAnnotation
        label.textColor = Palette.awfullyOrange
        label.textAlignment = .left
        
        return label
    }()
    
    private let missionIdLabel: UILabel = {
        let label = UILabel()
        label.font = FontMachine.boldAnnotation
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    private let rocketInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontMachine.boldAnnotation
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    private let missionNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontMachine.body
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    private let missionIdRocketStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 0
        
        return stackView
    }()
    
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Layout.interitemSpacing
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm dd/MM/yy"
        
        return dateFormatter
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: Public
    
    func setup(withViewModel viewModel: LaunchViewModel) {
        
        launchDateLabel.text = viewModel.createMissionTimeString(forDateFormatter: dateFormatter)
        missionIdLabel.text = viewModel.missionId
        rocketInfoLabel.textColor = viewModel.reusedStatusColor
        rocketInfoLabel.text = viewModel.formattedRocketName
        missionNameLabel.text = viewModel.missionName
    }
}


// MARK: Setup

extension LaunchInfoCell {
    
    private func setupUI() {
        backgroundColor = Palette.nearlyTransparentWhite
        
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
        
        missionIdRocketStackView.addArrangedSubviews(views: [
            missionIdLabel,
            rocketInfoLabel
            ])
        
        rootStackView.addArrangedSubviews(views: [
            launchDateLabel,
            missionIdRocketStackView,
            missionNameLabel
            ])
        
        addSubviewsForAutolayout(views: [
            rootStackView
            ])
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.insets.left),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.insets.right),
            rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.insets.top),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.insets.bottom),
            
            launchDateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Layout.dateWidthMultiplier),
            
            missionIdRocketStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Layout.missionRocketWidthMultiplier)
            ])
    }
}
