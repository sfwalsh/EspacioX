
import Foundation

struct SecondStage: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case payloads
    }
    
    struct Payload: Decodable {
        
        private enum CodingKeys: String, CodingKey {
            case reused
        }
        
        let reused: Bool?
    }
    
    let payloads: [Payload]
    
    var containsReusableParts: Bool {
        return payloads.reduce(false, { (res, next) -> Bool in
            if let reused = next.reused, reused == true { return true }
            return res
        })
    }
}
