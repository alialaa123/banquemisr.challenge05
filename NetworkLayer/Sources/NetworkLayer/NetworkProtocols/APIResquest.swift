
import Foundation

// MARK: - Request Protocol
public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: [String: String]? { get }
}
