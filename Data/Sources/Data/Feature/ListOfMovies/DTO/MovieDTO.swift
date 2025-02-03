
import Domain

public struct MovieDTO: Decodable {
    // MARK: - Properties
    public let id: Int
    public var movieTitle: String?
    public var movieImage: String?
    public var releaseDate: String?
    public var runtime: Int?
    public var genres: [MovieGenreDTO]?
    
    // MARK: - Coding Key
    public enum CodingKeys: String, CodingKey {
        case id, runtime, genres
        case movieTitle = "original_title"
        case movieImage = "poster_path"
        case releaseDate = "release_date"
    }
    
    // MARK: - Methods
    public func toDomain() -> Movie {
        Movie(
            id: self.id,
            movieTitle: self.movieTitle ?? "No Title",
            movieImage: self.movieImage ?? "",
            releaseDate: self.releaseDate ?? "",
            runtime: self.runtime,
            genres: self.genres?.map { $0.toDomain() }
        )
    }
}
