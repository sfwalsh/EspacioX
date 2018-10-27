
import Foundation

enum NetworkResult<T> {
    case success(value: T)
    case failure(error: Error)
}
