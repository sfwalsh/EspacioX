
import Foundation

enum LaunchFetchError: Error {
    case notFound, jsonDecoding, requestError
    case network(description: String)
}

extension LaunchFetchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            // FIXME: Localize these NSLocalizedString("", comment: "")
            return "Uh oh! something went wrong. Please try again later."
        case .jsonDecoding:
            return "There was a problem reading the response from the server"
        case .requestError:
            return "There was a problem communicating with mission control - try again later!"
        case .network(let description):
            return description
        }
    }
}
