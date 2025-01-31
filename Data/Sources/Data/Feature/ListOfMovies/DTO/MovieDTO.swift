
import Domain

public struct MovieDTO: Decodable {
    // MARK: - Properties
    public let id: Int
    public var movieTitle: String?
    public var movieImage: String?
    
    // MARK: - Coding Key
    public enum CodingKeys: String, CodingKey {
        case id
        case movieTitle = "original_title"
        case movieImage = "poster_path"
    }
    
    // MARK: - Methods
    public func toDomain() -> Movie {
        Movie(
            id: self.id,
            movieTitle: self.movieTitle ?? "No Title",
            movieImage: self.movieImage ?? ""
        )
    }
}
