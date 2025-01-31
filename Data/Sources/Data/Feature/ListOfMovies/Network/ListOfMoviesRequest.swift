
import Foundation
import NetworkLayer
import Domain

struct ListOfMoviesRequest: AuthenticateRequest, Retryable {
    typealias Response = ListOfMoviesResponseDTO

    var path: String
    var method: HTTPMethod { .get }
    var queryParameters: [String : String]?
    // TODO: - to remove this token from here and put it in keychain
    var authToken: String = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZmRmNzFkMWEyNmEzYWYxY2I1NWIwZjJjMmRjMWQwMyIsIm5iZiI6MTczODI0MDQyMi42NzcsInN1YiI6IjY3OWI3MWE2MDRjOGRjMzQ3Y2ZiZGMzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NAc77J7KOcqLKFwV0HNCqDETFa0xAzq3l9M78Zur2Ws"
    var maxRetries: Int = 2
    var retryDelay: TimeInterval = 2.0
}
