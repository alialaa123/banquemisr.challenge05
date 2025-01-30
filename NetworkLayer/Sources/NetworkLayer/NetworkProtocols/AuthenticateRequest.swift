
// MARK: - Authenticated Request Protocol
public protocol AuthenticateRequest: APIRequest {
    var authToken: String { get }
}

public extension AuthenticateRequest {
    var headers: [String: String]? {
        [
            "Authorization": "Bearer \(authToken)",
            "Content-Type": "application/json"
        ]
    }
}
