
import Foundation
import NetworkLayer
import Domain

struct ListOfMoviesRequest: AuthenticateRequest, Retryable {
    typealias Response = ListOfMoviesResponseDTO

    var path: String
    var method: HTTPMethod { .get }
    var queryParameters: [String : String]?
    var authToken: String
    
    var maxRetries: Int = 2
    var retryDelay: TimeInterval = 2.0
}
