
import UIKit

struct LaunchViewModel {
    
    enum ReuseStatus {
        case used, new
        
        var localizedDescription: String {
            switch self {
            case .used:
                return NSLocalizedString("REUSE_STATUS_USED", comment: "")
            case .new:
                return NSLocalizedString("REUSE_STATUS_NEW", comment: "")
            }
        }
    }
    
    private let launch: Launch
    
    init(withLaunch launch: Launch) {
        self.launch = launch
    }
    
    var reuseStatus: ReuseStatus {
        if launch.containsReusableParts {
            return .used
        }
        
        return .new
    }
    
    var missionName: String {
        return launch.missionName ?? NSLocalizedString("BLANK_MISSION_TEXT",
                                                       comment: "")
    }
    
    var missionId: String {
        return launch.missionId.first ?? NSLocalizedString("BLANK_MISSION_ID",
                                                           comment: "")
    }
    
    var formattedRocketName: String {
        if let rocketName = launch.rocketName {
            return "\(reuseStatus.localizedDescription) \(rocketName)"
        }
        
        return NSLocalizedString("BLANK_ROCKET_NAME", comment: "")
    }
    
    var reusedStatusColor: UIColor {
        switch reuseStatus {
        case .new:
            return Palette.luminousGreen
        case .used:
            return Palette.neonBlue
        }
    }
    
    func createDateCountdownComponentsInterval() -> DateComponents {
        let calendar = Calendar.current
        
        let launchDate = Date(timeIntervalSince1970: launch.launchDateUnixTimeStamp)
        let currentDate = Date()
        let components = calendar.dateComponents([.day, .hour, .minute, .second],
                                                 from: currentDate, to: launchDate)
        return components
    }
    
    func createMissionTimeString(forDateFormatter formatter: DateFormatter) -> String {
        let date = Date(timeIntervalSince1970: launch.launchDateUnixTimeStamp)
        return formatter.string(from: date)
    }
}
