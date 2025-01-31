
public protocol ListOfMoviesRepository {
    func getListOfMovies(with listType: String, page: Int) async throws -> [ListOfMovies]
}
