
import Foundation

enum API {
    
    private enum URLScheme: String {
        case https, http
    }
    
    private enum HTTPMethod: String {
        case GET, PUT, UPDATE, DELETE
    }
    
    private static let host: String = "https://api.spacexdata.com/v3"
    
    private static func createRequest(withPath path: String, method: HTTPMethod) -> URLRequest? {
        
        var components = URLComponents()
        components.host = host
        components.scheme = URLScheme.https.rawValue
        components.path = path
        
        guard let url = components.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    static func buildUpcomingLaunchesRequest() -> URLRequest? {
        return createRequest(withPath: "/launches/upcoming", method: .GET)
    }
    
    static func buildNextLaunchRequest() -> URLRequest? {
        return createRequest(withPath: "/launches/next", method: .GET)
    }
    
    static func buildLaunchDetailRequest(forId id: Int) -> URLRequest? {
        return createRequest(withPath: "/launches/id", method: .GET)
    }
}
