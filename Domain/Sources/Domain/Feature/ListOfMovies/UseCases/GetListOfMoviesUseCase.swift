
public protocol GetListOfMoviesUseCase {
    func execute(
        with listType: String,
        page: Int
    ) async throws -> [Movie]
}

public final class DefaultGetListOfMoviesUseCase: GetListOfMoviesUseCase {
    // MARK: - Properties
    private let repository: ListOfMoviesRepository

    // MARK: - Life cycle
    public init(repository: ListOfMoviesRepository) {
        self.repository = repository
    }

    // MARK: - Methods
    public func execute(
        with listType: String,
        page: Int
    ) async throws -> [Movie] {
        return try await repository.getListOfMovies(with: listType, page: page)
    }
}
