
import UIKit

struct LaunchViewModel {
    private let launch: Launch
    
    init(withLaunch launch: Launch) {
        self.launch = launch
    }
    
    var missionName: String {
        return ""
    }
    
    var missionTime: String {
        return ""
    }
    
    var missionId: String {
        return ""
    }
    
    var formattedRocketName: String {
        return ""
    }
    
    var reusedStatusColor: UIColor {
        return .white
    }
}
