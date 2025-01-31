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
    private let movieImage: String
    
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id && lhs.movieTitle == rhs.movieTitle && lhs.movieImage == rhs.movieImage
    }
    
    // MARK: - Life cycle
    public init(
        id: Int,
        movieTitle: String,
        movieImage: String
    ) {
        self.id = id
        self.movieTitle = movieTitle
        self.movieImage = movieImage
    }
    
    // MARK: - For View
    public var getImageURL: URL? {
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let fullURLString = "\(baseURLString)/\(movieImage)"
        return URL(string: fullURLString)
    }
}
