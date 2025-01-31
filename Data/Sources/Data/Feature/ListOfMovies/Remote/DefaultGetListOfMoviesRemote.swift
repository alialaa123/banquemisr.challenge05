
import Foundation
import Domain
import NetworkLayer

public final class DefaultGetGoldenPinBookingRemote: ListOfMoviesRepository {
    // MARK: - Properties
    private let client: NetworkClient
    
    // MARK: - Life cycle
    public init(client: NetworkClient) {
        self.client = client
    }
    
    // MARK: - Methods
    public func getListOfMovies(with listType: String, page: Int) async throws -> [ListOfMovies] {
        let queryParameters = ["page": String(page)]
        let request = ListOfMoviesRequest(path: listType, queryParameters: queryParameters)
        let listOfMoviesResponseDTO = try await client.sendWithRetry(request)
        let listOfMovies = listOfMoviesResponseDTO.results
        return listOfMovies.map { $0.toDomain() }
    }
}
