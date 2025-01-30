
import Foundation

// MARK: - Error handling
public enum NetworkError: Error, LocalizedError {
    /// Error cases
    case invalidURL
    case noData
    case unauthorized
    case decodingFailed(Error)
    case serverError(statusCode: Int, message: String)
    case requestFailed(Error)
    
    // MARK: - Property
    /// Error description
    public var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noData: return "No data found from your request"
        case .unauthorized: return "Unauthorized access"
        case .decodingFailed(let error): return "Decoding Error: \(error.localizedDescription)"
        case .serverError(let statusCode, let message): return "Server error (\(statusCode)): \(message)"
        case .requestFailed(let error): return "Failed with error: \(error.localizedDescription)"
        }
    }
}
