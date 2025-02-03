
import Foundation
import Domain
import NetworkLayer

public final class DefaultGetListOfMoviesRemote: ListOfMoviesRepository {
    // MARK: - Properties
    private let client: NetworkClient
    private let keychainManager: KeychainManager
    
    // MARK: - Life cycle
    public init(
        client: NetworkClient,
        keychainManager: KeychainManager = DefaultKeychainManager()
    ) {
        self.client = client
        self.keychainManager = keychainManager
    }
    
    // MARK: - Methods
    public func getListOfMovies(with listType: String, page: Int) async throws -> [Movie] {
        let token = try keychainManager.getToken(for: "authToken") ?? ""
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
