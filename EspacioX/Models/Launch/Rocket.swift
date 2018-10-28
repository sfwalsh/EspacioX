
import Foundation

struct Rocket: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case name = "rocket_name"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case fairings = "fairings"
    }
    
    let name: String?
    
    let firstStage: FirstStage?
    let secondStage: SecondStage?
    let fairings: Fairings?
    
    var containsReusableParts: Bool {
        let reusable = [firstStage?.containsReusableParts,
                        secondStage?.containsReusableParts,
                        fairings?.reused]
            .compactMap({$0})
            
        return reusable.contains(true)
    }
}
