
import Foundation

protocol LaunchListInteractor: class {
    func fetchUpcomingLaunches(completion: @escaping ((NetworkResult<[Launch]>) -> Void))
    func fetchNextLaunch(completion: @escaping ((NetworkResult<Launch>) -> Void))
}
