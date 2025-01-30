
public protocol ListOfMoviesRepository {
    func getListOfMovies(with listType: String) async throws -> ListOfMovies
}
