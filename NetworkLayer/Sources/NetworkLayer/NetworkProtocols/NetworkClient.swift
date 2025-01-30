
import Foundation

// MARK: - Network client protocol
public protocol NetworkClient {
    func send<T: APIRequest>(_ request: T) async throws -> T.Response
}

public extension NetworkClient {
    /// Send request with Retry implementation in case it throw error to retry
    func sendWithRetry<T: APIRequest & Retryable>(_ request: T) async throws -> T.Response {
        var retryCount = 0
        repeat {
            do {
                return try await send(request)
            } catch {
                if retryCount >= request.maxRetries { throw error }
                retryCount += 1
                
                try await Task.sleep(nanoseconds: UInt64(request.retryDelay * 1000000000))
            }
        } while retryCount <= request.maxRetries
        
        throw NetworkError.requestFailed(NSError(domain: "Failed to get Data", code: -1))
    }
}
