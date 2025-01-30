
import Foundation

public protocol Retryable {
    var maxRetries: Int { get }
    var retryDelay: TimeInterval { get }
}
