
import Foundation

struct FirstStage: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case cores
    }
    
    struct Core: Decodable {
        
        private enum CodingKeys: String, CodingKey {
            case reused
        }
        
        let reused: Bool?
    }
    
    let cores: [Core]
    
    var containsReusableParts: Bool {
        return cores.reduce(false, { (res, next) -> Bool in
            if let reused = next.reused, reused == true { return true }
            return res
        })
    }
}
