
import UIKit

final class LaunchListSectionHeaderCell: UITableViewHeaderFooterView, ReusableCell {
    
    private enum Layout {
        static let dateWidthMultiplier: CGFloat = 0.18
        static let missionRocketWidthMultiplier: CGFloat = 0.26
        static let interitemSpacing: CGFloat = 8
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 2, left: 12, bottom: 2, right: 12)
    }
    
    // FIXME: Strings
    
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Layout.interitemSpacing
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let dateTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Date"
        label.font = FontMachine.boldAnnotation
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    private let missionIdRocketTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Mission ID \r Rocket"
        label.font = FontMachine.boldAnnotation
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    private let missionNameTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Mission Name"
        label.font = FontMachine.boldAnnotation
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


// MARK: Setup

extension LaunchListSectionHeaderCell {
    
    private func setupUI() {
        setupBackgroundView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupBackgroundView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = Palette.iodineBlack
        self.backgroundView = backgroundView
    }
    
    private func setupSubviews() {
        rootStackView.addArrangedSubviews(views: [
            dateTitleLabel,
            missionIdRocketTitleLabel,
            missionNameTitleLabel
            ])
        
        addSubviewForAutolayout(view: rootStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.insets.left),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.insets.right),
            rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: Layout.insets.top),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.insets.bottom),

            dateTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Layout.dateWidthMultiplier),

            missionIdRocketTitleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: Layout.missionRocketWidthMultiplier)
            ])
    }
}
