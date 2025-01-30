
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
    public func getListOfMovies(with listType: String) async throws -> ListOfMovies {
        let request = ListOfMoviesRequest(path: listType)
        let listOfMoviesDTO = try await client.sendWithRetry(request)
        return listOfMoviesDTO.toDomain()
    }
}
