
import Foundation

final class LaunchListDefaultInteractor: LaunchListInteractor {
    func fetchUpcomingLaunches(completion: @escaping ((NetworkResult<[Launch]>) -> Void)) {
        guard let request = API.buildUpcomingLaunchesRequest() else {
            completion(.failure(error: LaunchFetchError.requestError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                completion(.failure(error: LaunchFetchError.network(description: error.localizedDescription)))
                return
            }
            
            guard let data = data,
                let launches = self?.parseLaunchListResponseData(data: data) else {
                    completion(.failure(error: LaunchFetchError.jsonDecoding))
                    return
            }
            
            completion(.success(value: launches))
        }.resume()
    }
    
    func fetchNextLaunch(completion: ((NetworkResult<Launch>) -> Void)) {
        
    }
    
    private func parseLaunchListResponseData(data: Data) -> [Launch]? {
        return try? JSONDecoder().decode([Launch].self, from: data)
    }
}
