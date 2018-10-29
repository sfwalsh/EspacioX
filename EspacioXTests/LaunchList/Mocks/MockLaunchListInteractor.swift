
import Foundation

@testable import EspacioX

final class MockLaunchListInteractor: LaunchListInteractor {
    
    struct DidCall {
        var fetchUpcomingLaunches: Bool = false
        var fetchNextLaunch: Bool = false
    }
    
    var didCall = DidCall()
    
    private let upcomingLaunchResult: NetworkResult<[Launch]>
    private let nextLaunchResult: NetworkResult<Launch>
    
    init(withUpcompingLaunchResult upcomingLaunchResult: NetworkResult<[Launch]>,
         nextLaunchResult: NetworkResult<Launch>) {
        self.upcomingLaunchResult = upcomingLaunchResult
        self.nextLaunchResult = nextLaunchResult
    }
    
    func fetchUpcomingLaunches(completion: @escaping ((NetworkResult<[Launch]>) -> Void)) {
        didCall.fetchUpcomingLaunches = true
        completion(upcomingLaunchResult)
    }
    
    func fetchNextLaunch(completion: @escaping ((NetworkResult<Launch>) -> Void)) {
        didCall.fetchNextLaunch = true
        completion(nextLaunchResult)
    }
}
