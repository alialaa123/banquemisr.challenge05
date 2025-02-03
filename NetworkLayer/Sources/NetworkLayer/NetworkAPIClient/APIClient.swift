
import Foundation

public final class APIClient: NetworkClient {
    // MARK: - Properties
    private let baseURL: String
    private let session: URLSessionProtocol
    private let jsonDecoder: JSONDecoder
    
    // MARK: - Life cycle
    public init(
        baseURL: String,
        session: URLSessionProtocol = URLSession.shared,
        jsonDecoder: JSONDecoder = JSONDecoder()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.jsonDecoder = jsonDecoder
    }
    
    // MARK: - Methods
    /// Helper func for build URL Request
    private func buildURLRequest<T: APIRequest>(from request: T) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: baseURL + request.path) else {
            throw NetworkError.invalidURL
        }
        
        // Adding query parameters
        urlComponents.queryItems = request.queryParameters?.map {
            URLQueryItem(
                name: $0.key,
                value: $0.value
            )
        }
        
        // Checking for URL validation
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.timeoutInterval = 10
        
        // Check if request is POST
        // Encode body for POST Methods
        if request.method == .post {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        }
        
        return urlRequest
    }
    
    /// Request response validation
    private func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.noData
        }
        
        switch httpResponse.statusCode {
        case 200...299: return
        case 401: throw NetworkError.unauthorized
        default:
            let message = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw NetworkError.serverError(statusCode: httpResponse.statusCode, message: message)
        }
    }
    
    /// Data Decode
    private func decode<T: Decodable>(data: Data, for type: T.Type) throws -> T {
        do {
            return try jsonDecoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
    
    /// Request Implementation
    public func send<T: APIRequest>(_ request: T) async throws -> T.Response {
        let urlRequest = try buildURLRequest(from: request)
        let (data, response) = try await session.data(for: urlRequest)
        try validate(response: response, data: data)
        return try decode(data: data, for: T.Response.self)
    }
}
