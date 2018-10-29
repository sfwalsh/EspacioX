
import Foundation

struct Fairings: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case reused
    }
    
    let reused: Bool?
}
