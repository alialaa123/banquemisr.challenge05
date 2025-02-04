
public protocol GetListOfMoviesUseCase {
    func execute(
        with listType: String,
        page: Int
    ) async throws -> [Movie]
}

public final class DefaultGetListOfMoviesUseCase: GetListOfMoviesUseCase {
    // MARK: - Properties
    private let repository: ListOfMoviesRepository
    private let cachingRepository: GetListOfMoviesCachingRepository & InsertMoviesIntoCachingRepository
    
    // MARK: - Life cycle
    public init(
        repository: ListOfMoviesRepository,
        cachingRepository: GetListOfMoviesCachingRepository & InsertMoviesIntoCachingRepository
    ) {
        self.repository = repository
        self.cachingRepository = cachingRepository
    }

    // MARK: - Methods
    public func execute(
        with listType: String,
        page: Int
    ) async throws -> [Movie] {
        do {
            let movies = try await repository.getListOfMovies(with: listType, page: page)
            if listType == "now_playing" && page == 1 {
                try await cachingRepository.insertMovies(movies: movies)
            }
            return movies
        } catch {
            if let cachedMovies = try? await cachingRepository.fetchMovies() {
                return cachedMovies
            }
            throw error
        }
    }
}
