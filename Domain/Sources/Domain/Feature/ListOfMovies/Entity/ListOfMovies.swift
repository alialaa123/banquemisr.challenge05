//
//  ListOfMovies.swift
//  Domain
//
//  Created by ali alaa on 30/01/2025.
//

import Foundation

public struct ListOfMovies {
    // MARK: - Properties
    public let id: Int
    public let movieTitle: String
    public let movieImage: String
    
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
}
