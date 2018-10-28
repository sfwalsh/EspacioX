
import Foundation

struct Launch: Decodable {
    
    /*
     flight_number
     mission_name
     mission_id
     launch_date_unix
     rocket_name
     first_stage/cores/[{reused}]
     second_stage/payloads/[{reused}]
     fairings/reused
     */
    
    private enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case missionId = "mission_id"
        case launchDateUnixTimeStamp = "launch_date_unix"
        case rocket
    }
    
    let flightNumber: Int
    let missionName: String?
    let missionId: [String]
    let launchDateUnixTimeStamp: Double

    // not exposed as we only want access to the reused value & name
    private let rocket: Rocket?
    
    var rocketName: String? {
        return rocket?.name
    }
    
    var containsReusableParts: Bool {
        return rocket?.containsReusableParts ?? false
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        flightNumber = try values.decode(Int.self, forKey: .flightNumber)
        missionName = try values.decodeIfPresent(String.self, forKey: .missionName)
        missionId = try values.decodeIfPresent([String].self, forKey: .missionId) ?? []
        launchDateUnixTimeStamp = try values.decodeIfPresent(Double.self, forKey: .launchDateUnixTimeStamp) ?? 0
        rocket = try values.decodeIfPresent(Rocket.self, forKey: .rocket)
    }
}
