
import XCTest

@testable import EspacioX

class APITests: XCTestCase {
    
    func testUpcomingLaunchesRequest() {
        let request = API.buildUpcomingLaunchesRequest()
        
        XCTAssert(request?.httpMethod == "GET")
        XCTAssertEqual(request?.url?.absoluteString,
                       "https://api.spacexdata.com/v3/launches/upcoming")
    }
    
    func testNextLaunchRequest() {
        let request = API.buildNextLaunchRequest()
        
        XCTAssert(request?.httpMethod == "GET")
        XCTAssertEqual(request?.url?.absoluteString,
                       "https://api.spacexdata.com/v3/launches/next")
    }
}
