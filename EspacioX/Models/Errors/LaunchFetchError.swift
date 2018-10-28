
import Foundation

enum LaunchFetchError: Error {
    case notFound, jsonDecoding, requestError
    case network(description: String)
}

extension LaunchFetchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("LAUNCH_FETCH_ERROR_NOT_FOUND",
                                     comment: "")
        case .jsonDecoding:
            return NSLocalizedString("LAUNCH_FETCH_ERROR_JSON",
                                     comment: "")
        case .requestError:
            return NSLocalizedString("LAUNCH_FETCH_ERROR_REQUEST_ERROR", comment: "")
        case .network(let description):
            return description
        }
    }
}
