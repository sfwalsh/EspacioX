
import Foundation

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
    
    var rocketName: String {
        return ""
    }
    
    var hasReusedPieces: Bool {
        return false
    }
}
