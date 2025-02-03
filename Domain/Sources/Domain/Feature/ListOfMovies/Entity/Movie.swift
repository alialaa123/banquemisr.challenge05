//
//  Movie.swift
//  Domain
//
//  Created by ali alaa on 30/01/2025.
//

import Foundation

// marked as Sendable because I'm using Actor on the UI Updates
// which will need to make compiler to check for the model to be
// sure it can be shared across actors.
// sendable: to make sure it can safely cross actor boundaries.
public struct Movie: Sendable, Hashable, Equatable {
    // MARK: - Properties
    public let id: Int
    public let movieTitle: String
    public let movieImage: String
    public let releaseDate: String
    public var runtime: Int?
    public var genres: [MovieGenre]?
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id && lhs.movieTitle == rhs.movieTitle && lhs.movieImage == rhs.movieImage
    }
    
    // MARK: - Life cycle
    public init(
        id: Int,
        movieTitle: String,
        movieImage: String,
        releaseDate: String,
        runtime: Int? = nil,
        genres: [MovieGenre]? = nil
    ) {
        self.id = id
        self.movieTitle = movieTitle
        self.movieImage = movieImage
        self.releaseDate = releaseDate
        self.runtime = runtime
        self.genres = genres
    }
    
    // MARK: - For View
    public var getImageURL: URL? {
        let baseImageURL = ConfigHelper.imageBaseURL
        let fullURLString = "\(baseImageURL)\(movieImage)"
        return URL(string: fullURLString)
    }
    
    public var getGenresString: String {
        guard let genres = genres else { return "" }
        return genres.map(\.name).joined(separator: ", ")
    }
    
    public var getMovieDuration: String {
        guard let runtime = runtime else { return "" }
        return "\(runtime) min"
    }
}
