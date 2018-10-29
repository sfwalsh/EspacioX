
import Foundation
@testable import EspacioX

enum MockLaunchBuilder {
    
    static func build() -> Launch {
        return Launch(flightNumber: 0,
                      missionName: "Mission 1",
                      missionId: ["12345A"],
                      launchDateUnixTimeStamp: Date().timeIntervalSince1970,
                      rocket: nil)
    }
}
