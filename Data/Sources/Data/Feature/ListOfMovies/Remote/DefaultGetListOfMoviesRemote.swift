
import Foundation
import Domain
import NetworkLayer

public final class DefaultGetListOfMoviesRemote: ListOfMoviesRepository {
    // MARK: - Properties
    private let client: NetworkClient
    
    // MARK: - Life cycle
    public init(client: NetworkClient) {
        self.client = client
    }
    
    // MARK: - Methods
    public func getListOfMovies(with listType: String, page: Int) async throws -> [Movie] {
        let token = try KeychainManager().getToken(for: "authToken") ?? ""
        let queryParameters = ["page": String(page)]
        let request = ListOfMoviesRequest(
            path: listType,
            queryParameters: queryParameters,
            authToken: token
        )
        let listOfMoviesResponseDTO = try await client.sendWithRetry(request)
        let listOfMovies = listOfMoviesResponseDTO.results
        return listOfMovies.map { $0.toDomain() }
    }
}
